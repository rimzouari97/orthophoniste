import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/Home/level3/components/alert.dart';
import 'package:orthophoniste/Screens/Home/level3/pages/game.dart';
import 'package:orthophoniste/Screens/Home/level3/services/game_data.dart';
import 'package:orthophoniste/Screens/Home/level3/services/level.dart';
import 'package:orthophoniste/Screens/Home/level3/services/score.dart';
import 'package:orthophoniste/services/done_service.dart';

class HomeSpell extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeSpell> {
  final List <Level> levels = [
    Level(name: "Easy", number: 1, color: Colors.grey),
    Level(name: "Medium", number: 2, color: Colors.grey),
    Level(name: "Hard", number: 3, color: Colors.grey),
    Level(name: "Extreme", number: 4, color: Colors.grey)
  ];

  bool isLoading = false;

  Future<dynamic> canGoToNextLevel(int currentLevelNumber) async {
    if(currentLevelNumber == 1) {
      return true;
    }

    Level prevLevel = levels[currentLevelNumber - 2];
    
    GameData prevData = GameData(levelName: prevLevel.name);

    await prevData.getQuestions();

    if(prevData.questions[0] == -1) {
      setState(() {
        isLoading = false;
      });
      return Alert().showAlert(context, "Error!", "Please ensure you have an active internet connection!");
    } else if(prevData.questions[0] == -2) {
      setState(() {
        isLoading = false;
      });
      return Alert().showAlert(context, "Error!", "Something went wrong. Please try again later");
    }

    Score gameScore = Score(level: prevLevel.name);

    List<dynamic> gameScoreList = await gameScore.getScore();

    int totalQuestions = prevData.questions.length;
    int totalSolved = gameScoreList.length;

    // If user has solved more than 60% of questions from previous level then only allow to go for next level
    if((totalSolved / totalQuestions) * 100 > 60.0) {
      return true;
    }

    return false;
  }

  dynamic _goToGame(Level level) async {
    setState(() {
      isLoading = true;
    });

    if(await canGoToNextLevel(level.number)) {
      GameData instance = GameData(levelName: level.name);

      await instance.getQuestions();

      if(instance.questions[0] == -1) {
        Alert().showAlert(context, "Error!", "Please ensure you have an active internet connection!");
        setState(() {
          isLoading = false;
        });
        return;
      } else if(instance.questions[0] == -2) {
        Alert().showAlert(context, "Error!", "Something went wrong. Please try again later");
        setState(() {
          isLoading = false;
        });
        return;
      }

      Score gameScore = Score(level: level.name);

      List<dynamic> gameScoreList = await gameScore.getScore();


      Navigator.pushNamed(context, '/game', arguments: {
        'level': level,
        'questions': instance.questions,
        'gameScoreList': gameScoreList,
        'gameScore': gameScore
      });
    } else {
      Alert().showAlert(context, "Oops!", "Please finish questions from ${levels[level.number - 2].name} level to unlock ${level.name} level!");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text("Dyslexia"),
          actions: <Widget>[
            Tooltip(
              message: "message",
              child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                  children: [
                                    Icon(Icons.info, color: Colors.greenAccent),
                                    Text(' How to play ? ')
                                  ]
                              ),
                              content: Text("You have to click on the speaker button to hear the sound of the word before typing it to finish the word correctly"),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, child: Text('ok'),
                                  color: Colors.greenAccent,
                                )
                              ],
                            );
                          }
                      );
                    },
                    child: Icon(
                        Icons.info_outline

                    ),
                  )
              ),
            ),


          ],
        ),
        backgroundColor: Colors.teal,
      body: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 80.0, 8.0, 0.0),
        child: Column(
          children: <Widget>[
            Neumorphic(
              child: AppBar(
                iconTheme: IconThemeData.fallback(),
                backgroundColor: Colors.grey[300],
                centerTitle: true,
                title: Text(
                  "lexical Dyslexia",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              style: NeumorphicStyle(
                  depth: -8
              ),
            ),

            SizedBox(height: 40),
            !isLoading ? Expanded(
                child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(4, (index) {
                  return Center(
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: levels[index].color,
                      child: ListTile(
                        onTap: () {

                          _goToGame(levels[index]);
                        },
                        title: Center(
                          child: Image.asset("assets/lock.png"),
                        ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        contentPadding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0)
                      ),
                    )
                  );
                }),
              ),
            ) : Center(
              heightFactor: 10.0,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              )
            )
          ],
        ),
      ),)
    );
  }
}