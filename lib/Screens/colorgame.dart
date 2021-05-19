import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/models/done.dart';
import 'package:orthophoniste/services/done_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class ColorGame extends StatefulWidget {
  ColorGame({Key key}) : super(key: key);

  createState() => ColorGameState();
}

class ColorGameState extends State<ColorGame> {
  int endgame = 0;
  int scoore = 0;
  String _idUser;
  String lastscore = "0";

  DoneService get service => GetIt.I<DoneService>();

  Future<bool> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        debugPrint('Step 2, fetch data');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        _idUser = preferences.getString('UserId');
        Done done = await service.getLastScore(
            Done(idUser: _idUser, idExercice: "6074abf282c71b0015918da3"));

        if (!done.score.isEmpty) {
          lastscore = done.score;
        }

        return true;
      });

  /// Map to keep track of score
  final Map<String, bool> score = {};

  /// Choices for game
  final Map choices = {
    '🍏': Colors.green,
    '🍋': Colors.yellow,
    '🍅': Colors.red,
    '🍇': Colors.purple,
    '🥥': Colors.brown,
    '🥕': Colors.orange
  };

  // Random seed to shuffle order of items.
  int seed = 0;

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Scaffold(
          appBar: AppBar(
              title: Text('les couleurs    Score ${scoore} '),
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
                                Text('  Info . ')
                              ]),
                              content: Text("Exercice " + " affecter a "),
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
              //Text('les couleurs    Score ${score.length} /6'),
              backgroundColor: Colors.deepPurpleAccent.shade100),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                score.clear();
                scoore = 0;
                endgame = 0;
                seed++;
              });
            },
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bgcolor.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: choices.keys.map((emoji) {
                      return Draggable<String>(
                        data: emoji,
                        child: Emoji(emoji: score[emoji] == true ? '✅' : emoji),
                        feedback: Emoji(emoji: emoji),
                        childWhenDragging: Emoji(emoji: '🌱'),
                      );
                    }).toList()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: choices.keys
                      .map((emoji) => _buildDragTarget(emoji))
                      .toList()
                        ..shuffle(Random(seed)),
                )
              ],
            ),
          ),
        );
      });

  Widget _buildDragTarget(emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        if (score[emoji] == true) {
          return Container(
            // color: Colors.white,
            child: Emoji(emoji: emoji),
            //child: Text('Correct!'),
            alignment: Alignment.center,
            height: 80,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueAccent,
                width: 3,
              ),
              color: Colors.white,
            ),
          );
        } else {
          //return Container(color: choices[emoji], height: 80, width: 200);
          return Container(
            height: 80,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueAccent,
                width: 3,
              ),
              color: choices[emoji],
            ),
          );
        }
      },
      onWillAccept: (data) => data == emoji,
      onAccept: (data) {
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
        setState(() {
          score[emoji] = true;
          plyr.play('success.mp3');
          scoore += 5;
          print(scoore);
          endgame++;
          if (endgame == 6) {
            showDialog(
                context: context,
                builder: (_) => NetworkGiffyDialog(
                      key: keys[1],
                      image: Image.network(
                        networkimg,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        "Bravo",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      description: Text(
                        'votre derniere est  ${lastscore} , votre score actuel est ${scoore}',
                        textAlign: TextAlign.center,
                      ),
                      buttonOkText: Text("ok"),
                      entryAnimation: EntryAnimation.RIGHT,
                      onlyOkButton: true,
                      onOkButtonPressed: () {
                        Navigator.of(context).pop();
                      },
                    ));

            print('end of the game');
            print(scoore.toString());
            print(String.fromCharCode(scoore));
            print(_idUser);
            Done done = Done(
                idExercice: "6074ab5b82c71b0015918da2",
                exerciceName: "color game",
                idToDo: "fff",
                score: scoore.toString(),
                idUser: _idUser);

            service.addEx(done).then((result) => {
                  print(result.data)
                  //  if (!result.errer) {print(result.errorMessage)}
                });
          }
        });
      },
      onLeave: (data) {
        setState(() {
          score[emoji] = false;
          plyr.play('wrong.mp3');
          scoore -= 4;
          print(scoore);
        });
      },
    );
  }
}

class Emoji extends StatelessWidget {
  Emoji({Key key, this.emoji}) : super(key: key);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        //height: 50,
        height: 60,
        //padding: EdgeInsets.all(10),
        padding: EdgeInsets.all(0),
        child: Text(
          emoji,
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    );
  }
}

AudioCache plyr = AudioCache();
