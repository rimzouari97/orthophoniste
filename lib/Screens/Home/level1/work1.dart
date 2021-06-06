import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/Home/level1/TileModel.dart';
import 'package:orthophoniste/Screens/Home/level1/data.dart';
import 'package:orthophoniste/Screens/Home/level2/custom_dialog.dart';
import 'package:orthophoniste/Screens/Home/screens/details_screen.dart';
import 'package:orthophoniste/models/done.dart';
import 'package:orthophoniste/services/done_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
int i = 0;
class _HomeState extends State<Home> {
  List<TileModel> gridViewTiles = new List<TileModel>();
  List<TileModel> questionPairs = new List<TileModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reStart();
  }


  void reStart() {

    myPairs = getPairs();
    myPairs.shuffle();
    gridViewTiles = myPairs;

    Future.delayed(const Duration(seconds: 5), () {
// Here you can write your code
    int i =0;

     setState(() {
        print("5 seconds done");
        // Here you can write your code for open new view
        questionPairs = getQuestionPairs();
        gridViewTiles = questionPairs;
        selected = false;
      });
    });


  }

  String _idUser;
  String lastscore = "0";
  DoneService get service => GetIt.I<DoneService>();

  Future<bool> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        debugPrint('Step 2, fetch data');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        _idUser = preferences.getString('UserId');
        Done done = await service.getLastScore(
            Done(idUser: _idUser, idExercice: "6088d3d7079cb400154a37dd"));
        if (!done.score.isEmpty) {
          lastscore = done.score;
        }
        return true;
      });


  @override
  Widget build(BuildContext context) => FutureBuilder(
  future: fetchData(),
  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Memory game"),
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
                                    Icon(Icons.info, color: Colors.amber),
                                    Text(' How to play ? ')
                                  ]
                              ),
                              content: Text("This is a matching game, try to find all the identical pairs by selecting two pictures for each try"),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, child: Text('ok'),
                                  color: Colors.amber,
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Neumorphic(
                  child: AppBar(
                    iconTheme: IconThemeData.fallback(),
                    backgroundColor: Colors.grey[300],
                    centerTitle: true,
                    title: Text(
                      "Visual memory",
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
                SizedBox(
                  height: 20,
                ),
                points !=80 ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Your previous score is   " + lastscore),
                    /*Text(
                      "$points/80",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),

                    Text(
                      "Points",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w300),
                    ),*/

                  ],
                ) : Container(),
                SizedBox(
                  height: 20,
                ),
                Neumorphic(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  style: NeumorphicStyle(
                      color: Colors.grey[300],
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12))),
                  child:
                  i != 8 ? GridView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisSpacing: 0.0, maxCrossAxisExtent: 100.0),
                    children: List.generate(gridViewTiles.length, (index) {
                      return Tile(
                        imagePathUrl: gridViewTiles[index].getImageAssetPath(),
                        tileIndex: index,
                        parent: this,
                      );
                    }),
                  ) : Container(
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                             setState(() {
                                i=0;
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
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500
                              ),),

                            ),
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return DetailsScreen();
                                  }));
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.amber[400],
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Text("Home", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500
                              ),),
                            ),
                          ),
                          SizedBox(height: 20,),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.amber[400],
                                boxShape:
                                NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),

                            ),
                              onPressed: () async {
                                await showDialog(context: context,
                                    builder: (BuildContext context) => CustomDialog(
                                        title: "GOOD JOB!",
                                        description: points.toString(),
                                        buttonText: "OK"));
                                print('end of the game');
                                Done done = Done(
                                    idExercice: "6088d3d7079cb400154a37dd",
                                    exerciceName: "Memory game ",
                                    idToDo: "mm",
                                    score: points.toString(),
                                    idUser: _idUser);
                                service.addEx(done).then((result) => {
                                  print(result.data),
                                 // if (!result.errer) {print(result.errorMessage)}
                                });

                              },
                            padding: const EdgeInsets.fromLTRB(72, 13, 72, 13),
                            child: Text(
                              "Score",
                              style: TextStyle(color: Colors.black, fontSize: 17),

                            ),
                          )
                        ],
                      )
                  ),
                ),



              ],
            ),

          ),

        ),
      ),);
  });
}



class Tile extends StatefulWidget {
  String imagePathUrl;
  int tileIndex;
  _HomeState parent;

  Tile({this.imagePathUrl, this.tileIndex, this.parent});


  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
           setState(() {
            myPairs[widget.tileIndex].setIsSelected(true);
          });
          if (selectedTile != "") {
            /// testing if the selected tiles are same
            if (selectedTile == myPairs[widget.tileIndex].getImageAssetPath()) {
              points = points + 10;
              i++;
              print(i);
              //print(selectedTile + " this " + widget.imagePathUrl);
              TileModel tileModel = new TileModel();
              //print(widget.tileIndex);
              selected = true;

              Future.delayed(const Duration(seconds: 2), () {
                tileModel.setImageAssetPath("");
                myPairs[widget.tileIndex] = tileModel;
                print(selectedIndex);
                myPairs[selectedIndex] = tileModel;
                this.widget.parent.setState(() {
                });

                setState(() {
                  selected = false;

                });
                selectedTile = "";

              });

            } else {
              print(selectedTile +
                  " this " +
                  myPairs[widget.tileIndex].getImageAssetPath());
              print("wrong choice");
              points = points - 5;
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
              selectedTile = myPairs[widget.tileIndex].getImageAssetPath();
              selectedIndex = widget.tileIndex;

            });

           
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

          child: Image.asset("assets/correct.png"),
        ),
      ),
    );

  }


}
