import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:orthophoniste/Screens/Home/level2/TileModel_img.dart';
import 'package:orthophoniste/Screens/Home/level2/data_img.dart';

import '../constants.dart';
class Home2 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home2> {
  List<TileModelImage> gridViewTiles = new List<TileModelImage>();
  List<TileModelImage> questionPairs = new List<TileModelImage>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reStart();

  }



  void reStart()  {



    myPairs = getPairs();
    myPairs.shuffle();

    gridViewTiles = myPairs;
    Future.delayed(const Duration(seconds: 3), () {
// Here you can write your code
     print(gridViewTiles[0].toString());
      setState(() {
        print("2 seconds done");
        // Here you can write your code for open new view
        questionPairs = getQuestionPairs();
        gridViewTiles = questionPairs;
        selected = false;
      });

    });
  }

  static const duration = const Duration(seconds: 1);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                points != 800 ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$points/800",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Points",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                  ],
                ) : Container(),
                SizedBox(
                  height: 20,
                ),
                points != 800 ? GridView(
                  shrinkWrap: true,
                  //physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 0.0, maxCrossAxisExtent: 100.0),
                  children: List.generate(gridViewTiles.length, (index) {
                 //   print(questionPairs[index].getSound());
                    // print(index);
                 //   print(gridViewTiles[index].imageAssetPath);
                    return Tile(
                      imagePathUrl: gridViewTiles[index].getImageAssetPath(),
                      tileIndex: index,
                      parent: this,
                      sound: gridViewTiles[index].getSound()
                    );

                  }),
                ) : Container(
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              points = 0;
                              reStart();
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.amber[400],
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text("Replay", style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                        SizedBox(height: 20,),

                      ],
                    )
                ),


              ],
            ),

          ),

      ),
    );
  }
}



class Tile extends StatefulWidget {
  String imagePathUrl;
  int tileIndex;
  _HomeState parent;
  String sound;

  Tile({this.imagePathUrl, this.tileIndex, this.parent,this.sound});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.sound.toString());
        final player = AudioCache();
        print(widget.sound);
          player.play(myPairs[widget.tileIndex].sound);
        if (!selected) {
          setState(() {
            myPairs[widget.tileIndex].setIsSelected(true);
          });
          if (selectedTile != "") {
            /// testing if the selected tiles are same
            if (selectedTile == myPairs[widget.tileIndex].getSound()) {
              print("add point");
              points = points + 100;
              print(selectedTile + " thishis" + widget.imagePathUrl);
              TileModelImage tileModel = new TileModelImage();
              print(widget.tileIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                tileModel.setImageAssetPath("");
                myPairs[widget.tileIndex] = tileModel;
                print(selectedIndex);
                myPairs[selectedIndex] = tileModel;
                this.widget.parent.setState(() {});
                setState(() {
                  selected = false;
                });
                selectedTile = "";
              });
            } else {
              print(selectedTile +
                  " thishis " +
                  myPairs[widget.tileIndex].getImageAssetPath());
              print("wrong choice");
              print(widget.tileIndex);
              print(selectedIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                this.widget.parent.setState(() {
                  myPairs[widget.tileIndex].setIsSelected(false);
                  myPairs[selectedIndex].setIsSelected(false);
                });
                setState(() {
                  selected = false;
                });
              });

              selectedTile = "";
            }
          } else {
            setState(() {
              selectedTile = myPairs[widget.tileIndex].getSound();
              selectedIndex = widget.tileIndex;
            });

            print(selectedTile);
            print(selectedIndex);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: myPairs[widget.tileIndex].getImageAssetPath() != ""
            ? Image.asset(myPairs[widget.tileIndex].getIsSelected()
            ? myPairs[widget.tileIndex].getImageAssetPath()
            : widget.imagePathUrl)
            : Container(
          color: Colors.white,
          child: Image.asset("assets/correct.png"),
        ),
      ),
    );
  }
}
