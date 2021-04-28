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
      if (mounted ) setState(() {
        print("2 seconds done");
        // Here you can write your code for open new view
        questionPairs = getQuestionPairs();
        gridViewTiles = questionPairs;
        selected = false;
      });
    });


  }

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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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

                    title: Text(
                      "      Mémoire visuelle",
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
                Neumorphic(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  style: NeumorphicStyle(
                      color: Colors.grey[300],
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12))),
                  child: points != 800 ? GridView(
                    shrinkWrap: true,
                    //physics: ClampingScrollPhysics(),
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
                              if (mounted) setState(() {
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
                                print(String.fromCharCode(points));
                                print(_idUser);
                                Done done = Done(
                                    idExercice: "4",
                                    exerciceName: "Memory game ",
                                    idToDo: "mm",
                                    score: points.toString(),
                                    idUser: _idUser);
                                service.addEx(done).then((result) => {
                                  print(result.data),
                                  if (!result.errer) {print(result.errorMessage)}
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
  }
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
          if (mounted) setState(() {
            myPairs[widget.tileIndex].setIsSelected(true);
          });
          if (selectedTile != "") {
            /// testing if the selected tiles are same
            if (selectedTile == myPairs[widget.tileIndex].getImageAssetPath()) {
              points = points + 100;
              print(points);
              //print(selectedTile + " this " + widget.imagePathUrl);
              TileModel tileModel = new TileModel();
              //print(widget.tileIndex);
              selected = true;

              Future.delayed(const Duration(seconds: 2), () {
                tileModel.setImageAssetPath("");
                myPairs[widget.tileIndex] = tileModel;
                print(selectedIndex);
                myPairs[selectedIndex] = tileModel;
                if (mounted) this.widget.parent.setState(() {
                });

                if (mounted) setState(() {
                  selected = false;

                });
                selectedTile = "";

              });

            } else {
              print(selectedTile +
                  " this " +
                  myPairs[widget.tileIndex].getImageAssetPath());
              print("wrong choice");
              //print(widget.tileIndex);
              //print(selectedIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) this.widget.parent.setState(() {
                  myPairs[widget.tileIndex].setIsSelected(false);
                  myPairs[selectedIndex].setIsSelected(false);
                });

                if (mounted) setState(() {
                  selected = false;
                });
              });

              selectedTile = "";
            }

          } else {
            if (mounted) setState(() {
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
