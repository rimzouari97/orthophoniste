import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orthophoniste/data/draggable_animal.dart';
import 'package:audioplayers/audio_cache.dart';

class DragPicture extends StatefulWidget {
  @override
  _DragPictureState createState() => _DragPictureState();
}

class _DragPictureState extends State<DragPicture> {
  int scoore = 0;
  int endgame = 0;
  List<bool> _isDone = [false, false, false];
  List<bool> elementState = [false, false, false];
  double itemsize = 70;
  double newsize = 70;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('jeux des formes Score ${scoore}'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                                      if (data.name == item.name) {
                                        return true;
                                      } else {
                                        print('wrong');
                                        // plyr.play('wrong.mp3');
                                        return false;
                                      }
                                    },
                                    onAccept: (e) {
                                      setState(() {
                                        _isDone[itemlist.indexOf(e)] = true;
                                        elementState[itemlist.indexOf(e)] =
                                            true;
                                        plyr.play('success.mp3');
                                        scoore += 5;
                                        print(scoore);
                                        endgame++;
                                        if (endgame == 3) {
                                          print('end of the game');
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
                                      return _isDone[itemlist.indexOf(item)]
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
                          color: Colors.black54.withOpacity(0.8), width: 3)),
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
                                      child: elementState[itemlist.indexOf(e)]
                                          ? Container(
                                              width: itemsize,
                                              height: itemsize,
                                            )
                                          : Container(
                                              height: itemsize,
                                              width: itemsize,
                                              child:
                                                  SvgPicture.asset(e.address),
                                            ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

AudioCache plyr = AudioCache();
