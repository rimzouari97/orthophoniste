import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/data/draggable_animal.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:orthophoniste/models/done.dart';
import 'package:orthophoniste/services/done_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class DragPicture extends StatefulWidget {
  @override
  _DragPictureState createState() => _DragPictureState();
}

class _DragPictureState extends State<DragPicture> {
  int scoore = 0;
  int endgame = 0;
  String lastscore = "0";
  String _idUser;
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

  List<bool> _isDone = [false, false, false];
  List<bool> elementState = [false, false, false];
  double itemsize = 70;
  double newsize = 70;
  Done last;
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('jeux des formes '),
            backgroundColor: Colors.deepPurpleAccent.shade100,
            //backgroundColor: Colors.orangeAccent.shade100,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bgcolor.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('score   ${scoore.toString()}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Center(
                      child: Container(
                        width: 500,
                        height: 180,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/board3.png"))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              children: itemlist
                                  .map((item) => Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: DragTarget<Itemdata>(
                                          onWillAccept: (data) {
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
                                            if (data.name == item.name) {
                                              return true;
                                            } else {
                                              print('wrong');

                                              // plyr.play('wrong.mp3');
                                              return false;
                                            }
                                          },
                                          onAccept: (e) {
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
                                              _isDone[itemlist.indexOf(e)] =
                                                  true;
                                              elementState[
                                                  itemlist.indexOf(e)] = true;
                                              plyr.play('success.mp3');
                                              scoore += 5;
                                              print(scoore);
                                              endgame++;
                                              if (endgame == 3) {
                                                print(_idUser);
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        NetworkGiffyDialog(
                                                          key: keys[1],
                                                          image: Image.network(
                                                            "https://c.tenor.com/MOLq4Zd9tqcAAAAj/clap-around-of-applause.gif",
                                                            fit: BoxFit.cover,
                                                          ),
                                                          title: Text(
                                                            "Bravo",
                                                            style: TextStyle(
                                                              fontSize: 22.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          description: Text(
                                                            'Bravo votre score est ${scoore}',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          entryAnimation:
                                                              EntryAnimation
                                                                  .RIGHT,
                                                          onOkButtonPressed:
                                                              () {},
                                                        ));

                                                print('end of the game');
                                                Done done = Done(
                                                    idExercice:
                                                        "6074abf282c71b0015918da3",
                                                    exerciceName: "shape game",
                                                    idToDo: "fff",
                                                    score: scoore.toString(),
                                                    idUser: _idUser);

                                                service
                                                    .addEx(done)
                                                    .then((result) => {
                                                          print(result.data)
                                                          /*if (!result.errer)
                                                    {print(result.errorMessage)}*/
                                                        });
                                              }
                                            });
                                          },
                                          onLeave: (data) {
                                            setState(() {
                                              plyr.play('wrong.mp3');
                                              scoore -= 2;
                                              print(scoore);
                                            });
                                          },
                                          builder: (BuildContext context,
                                              List incoming, List rejected) {
                                            return _isDone[
                                                    itemlist.indexOf(item)]
                                                ? Container(
                                                    height: newsize,
                                                    width: newsize,
                                                    child: SvgPicture.asset(
                                                        item.address),
                                                  )
                                                : Container(
                                                    height: itemsize,
                                                    width: itemsize,
                                                    child: SvgPicture.asset(
                                                      item.address,
                                                      color: Colors.black45,
                                                    ),
                                                  );
                                          },
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 500,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.7),
                            border: Border.all(
                                color: Colors.black54.withOpacity(0.8),
                                width: 3)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Wrap(
                              children: itemlist
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Draggable<Itemdata>(
                                          data: e,
                                          onDragStarted: () {
                                            setState(() {
                                              newsize = 80;
                                            });
                                          },
                                          childWhenDragging: Container(
                                            height: itemsize,
                                            width: itemsize,
                                          ),
                                          feedback: Container(
                                            height: itemsize,
                                            width: itemsize,
                                            child: SvgPicture.asset(e.address),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: elementState[
                                                    itemlist.indexOf(e)]
                                                ? Container(
                                                    width: itemsize,
                                                    height: itemsize,
                                                  )
                                                : Container(
                                                    height: itemsize,
                                                    width: itemsize,
                                                    child: SvgPicture.asset(
                                                        e.address),
                                                  ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text("last score here  " + lastscore),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

AudioCache plyr = AudioCache();
