import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/Home/level2/custom_dialog.dart';
import 'package:orthophoniste/Screens/Home/level5/models/question_model.dart';
import 'package:orthophoniste/Screens/Home/level5/styles/styles.dart';
import 'package:orthophoniste/Screens/Home/level5/views/level.dart';

import 'package:orthophoniste/Screens/Home/level5/data/data.dart';
import 'package:orthophoniste/models/done.dart';
import 'package:orthophoniste/services/done_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Game extends StatefulWidget {
  final QuestionModel question;

  Game({@required this.question});

  @override
  _GameState createState() => _GameState();
}


class _GameState extends State<Game> {
  List<String> letters;
  List<String> addedLetters;
  int scoore = 0;
  String _idUser;

  DoneService get service => GetIt.I<DoneService>();

  Future<bool> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        debugPrint('Step 2, fetch data');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        _idUser = preferences.getString('UserId');

        return true;
      });
  @override
  void initState() {
    super.initState();
    addedLetters = List<String>(widget.question.question.split('').length);
    letters = widget.question.question.split('');
    letters.shuffle();
  }

  compareWord() {
    if (addedLetters.join('') == widget.question.question) {
      QuestionModel nextLevel = questions
          .firstWhere((element) => element.id == widget.question.id + 1);
      setState(() {
        nextLevel.unlock = true;
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('GOOD JOB 🎉'),
                  content: Text('Next level'),
                  actions: [
                    RaisedButton(
                      child: Text('Next'),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Levels()));
                        //scoore += 10;
                        print('end of the game');
                        print(_idUser);
                        Done done = Done(
                            idExercice: "6088d462079cb400154a37e1",
                            exerciceName: "Dysorthographie ",
                            idToDo: "mm",
                            score: scoore.toString(),
                            idUser: _idUser);
                        service.addEx(done).then((result) => {
                          print(result.data),
                          if (!result.errer) {print(result.errorMessage)}
                        });
                      },
                    )
                  ],
                ));
      });


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.question.imageUrl)
                  )),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        itemCount: addedLetters.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: addedLetters.length),
                        itemBuilder: (context, index) =>
                            DragTarget(onAccept: (String data) {
                              setState(() {
                                addedLetters[index] = data;
                                compareWord();
                                scoore +=10;
                              });
                            }, builder: (context, _, __) {
                              return GestureDetector(
                                onLongPress: () async {
                                  setState(() => addedLetters[index] = null);
                                  showDialog(context: context,
                                      builder: (BuildContext context) => CustomDialog(
                                          title: "GOOD JOB!",
                                          description: scoore.toString(),
                                          buttonText: "OK"));
                                },
                                child: NeumorphicButton(
                                  style: NeumorphicStyle(
                                    color: Colors.grey[400],
                                    boxShape:
                                    NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),

                                  ),
                                  child: Center(
                                    child: Text(
                                        addedLetters[index] != null
                                            ? addedLetters[index]
                                            : '?',
                                        style: mainTextStyle),
                                  ),
                                ),
                              );
                            })),

                  ),

                  Expanded(
                    child: GridView.builder(
                      itemCount: letters.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: letters.length),
                      itemBuilder: (context, index) => Draggable(
                        data: letters[index],
                        feedback: Container(
                          color: Colors.amber,
                          height: 50,
                          width: 50,
                          child: Center(
                              child:
                                  Text(letters[index], style: mainTextStyle)),
                        ),
                        child: NeumorphicButton(
                          style: NeumorphicStyle(
                            color: Colors.amber,
                            boxShape:
                            NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),

                          ),
                          child: Center(
                            child: Text(letters[index], style: mainTextStyle),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
