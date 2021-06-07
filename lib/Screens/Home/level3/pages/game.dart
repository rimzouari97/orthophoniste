import 'package:flutter/material.dart';
import 'package:orthophoniste/Screens/Home/level3/components/game_screen.dart';
import 'package:orthophoniste/Screens/Home/level3/services/level.dart';
import 'package:orthophoniste/Screens/Home/level3/services/score.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  dynamic data;
  Level level;
  List<dynamic> questions;
  List<dynamic> gameScoreList;
  Score gameScore;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    level = data['level'];
    questions = data['questions'];
    gameScoreList = data['gameScoreList'];
    gameScore = data['gameScore'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('${level.name} Level'),
        centerTitle: true,
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
                                  Icon(Icons.info, color: Colors.teal),
                                  Text(' How to play ? ')
                                ]
                            ),
                            content: Text("Press on the speaker to listen "),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text('ok'),
                                color: Colors.teal,
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
      body: PageView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return GameScreen(
            question: questions[index], 
            level: level.number.toString(), 
            gameScoreList: gameScoreList,
            gameScore: gameScore
          );
        },
      ),
    );
  }
}