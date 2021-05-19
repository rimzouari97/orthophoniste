import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/models/done.dart';
import 'package:orthophoniste/services/done_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

//void main() => runApp(MyApp());

class Myquizz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyquizzState();
  }
}

class _MyquizzState extends State<Myquizz> {
  String _idUser;
  String lastscore = "0";
  DoneService get service => GetIt.I<DoneService>();

  Future<bool> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        debugPrint('Step 2, fetch data');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        _idUser = preferences.getString('UserId');

        Done done = await service.getLastScore(
            Done(idUser: _idUser, idExercice: "6074b1a582c71b0015918da5"));

        if (!done.score.isEmpty) {
          lastscore = done.score;
        }

        return true;
      });

  final _questions = const [
    {
      'questionText': 'dog.wav',
      'answers': [
        {'text': 'assets/chat.png', 'score': -2},
        {'text': 'assets/ours.png', 'score': -2},
        {'text': 'assets/chien.png', 'score': 10},
        {'text': 'assets/cheval.png', 'score': -2},
      ]
    },
    {
      'questionText': 'elephant.wav',
      'answers': [
        {'text': 'assets/tigre.png', 'score': -2},
        {'text': 'assets/loup.png', 'score': -2},
        {'text': 'assets/girafe.png', 'score': -2},
        {'text': 'assets/elephant.png', 'score': 10},
      ]
    },
    {
      'questionText': 'lion.wav',
      'answers': [
        {'text': 'assets/zebre.png', 'score': -2},
        {'text': 'assets/lion.png', 'score': 10},
        {'text': 'assets/loup.png', 'score': -2},
        {'text': 'assets/lapin.png', 'score': -2},
      ]
    },
    {
      'questionText': 'wolf.wav',
      'answers': [
        {'text': 'assets/loup.png', 'score': 10},
        {'text': 'assets/zebre.png', 'score': -2},
        {'text': 'assets/girafe.png', 'score': -2},
        {'text': 'assets/poisson.png', 'score': -2},
      ]
    },
    {
      'questionText': 'cat.mp3',
      'answers': [
        {'text': 'assets/chat.png', 'score': 10},
        {'text': 'assets/elephant.png', 'score': -2},
        {'text': 'assets/cheval.png', 'score': -2},
        {'text': 'assets/poisson.png', 'score': -2},
      ]
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    String networkimg =
        'https://c.tenor.com/MOLq4Zd9tqcAAAAj/clap-around-of-applause.gif';

    const List<Key> keys = [
      Key('Network'),
      Key('Network Dialog'),
      Key('Flare'),
      Key('Flare Dialog'),
      Key('Asset'),
      Key('Asset dialog'),
    ];

    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');

      showDialog(
          context: context,
          builder: (_) => NetworkGiffyDialog(
                key: keys[1],
                image: Image.network(
                  networkimg,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  "Score",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                description: Text(
                  ' votre derniere est  ${lastscore} , votre score actuel est ${_totalScore}',
                  textAlign: TextAlign.center,
                ),
                entryAnimation: EntryAnimation.RIGHT,
                onOkButtonPressed: () {
                  Navigator.of(context).pop();
                },
                onlyOkButton: true,
              ));

      Done done = Done(
          idExercice: "6074b1a582c71b0015918da5",
          exerciceName: "quiz game",
          idToDo: "fff",
          score: _totalScore.toString(),
          idUser: _idUser);

      service.addEx(done).then((result) => {
            print(result.data)
            //  if (!result.errer) {print(result.errorMessage)}
          });
      //sprint(_totalScore); consomme web service
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('Quizz                   ${_questionIndex + 1}/5'),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(children: [
                                Icon(Icons.info, color: Colors.blueAccent),
                                Text(' How to play ? ')
                              ]),
                              content: Text(
                                  "this is a quiz game, try to match the sound of each animal with the right picture"),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('ok'),
                                  color: Colors.deepPurple,
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(Icons.info_outline),
                    )),
              ],
              backgroundColor: Colors.deepPurpleAccent.shade100,
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bgcolor.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: _questionIndex < _questions.length
                    ? Quiz(
                        answerQuestion: _answerQuestion,
                        questionIndex: _questionIndex,
                        questions: _questions,
                      ) //Quiz
                    : Result(_totalScore, _resetQuiz),
              ),
            ), //Padding
          ), //Scaffold
          debugShowCheckedModeBanner: false,
        ); //MaterialApp
      });
}
