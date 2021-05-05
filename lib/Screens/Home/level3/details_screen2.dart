import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/Home/constants.dart';
import 'package:orthophoniste/Screens/Home/level1/work1.dart';
import 'package:orthophoniste/Screens/Home/level2/work1_img.dart';
import 'package:orthophoniste/Screens/Home/level3/pages/home.dart';
import 'package:orthophoniste/Screens/Home/level3/services/level.dart';
import 'package:orthophoniste/Screens/Home/level4/screens/bottom_navigation_screen.dart';
import 'package:orthophoniste/Screens/Home/level4/widget/exercice.dart';
import 'package:orthophoniste/Screens/Home/level5/views/level.dart';


import 'package:orthophoniste/Screens/Home/widgets/bottom_nav_bar.dart';
import 'package:orthophoniste/Screens/Home/widgets/search_bar.dart';
import 'package:orthophoniste/models/done.dart';
import 'package:orthophoniste/models/todo_param.dart';
import 'package:orthophoniste/services/done_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen2 extends StatefulWidget {
  @override
  _Apprend createState() => new  _Apprend();
}
class _Apprend extends State<DetailsScreen2> {

  DoneService get service => GetIt.I<DoneService>();
  String _idUser;
  List<ToDoParam> listtodo;
  Future<List<ToDoParam>> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        debugPrint('Step 2, fetch data');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        _idUser = preferences.getString('UserId');

        return await service.getToDoListByIdP(Done(idUser: _idUser));
      });

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Access Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("No access ! please wait for your ortho!"),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
  future: fetchData(), builder: (BuildContext context, AsyncSnapshot<List<ToDoParam>> snapshot){
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "Let's remember!",
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "3-10 MIN Course",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6, // it just take 60% of total width
                      child: Text(
                        "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                      ),
                    ),
                    SizedBox(
                      width: size.width * .5, // it just take the 50% width
                      child: SearchBar(),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        SeassionCard(
                          seassionNum: 1,
                          sessionName: "Dyslexie L",
                          press: () {
                            var idDyslexieL = "6088d433079cb400154a37df";
                            var i = 1;
                            bool b = false;
                            for (var item in snapshot.data ){
                              if (item.idExercice == idDyslexieL){
                                b=true;
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return HomeSpell();
                                    }),
                                  );
                                });

                                } else if(snapshot.data.length == i && !b){
                                print ('no access');
                                _showMyDialog();
                              }
                              print(i);
                              i++;
                              }

                            },
                        ),
                        SeassionCard(
                          seassionNum: 2,
                          sessionName: "Dyslexie O",
                          press: () {
                            var idDyslexieO ="6088d443079cb400154a37e0";
                            var i =1;
                            bool b = false;
                            for (var item in snapshot.data){
                              if (item.idExercice == idDyslexieO){
                                b=true;
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return Exercice();
                                    }),
                                  );
                                  print ("access");
                                });

                                 } else if(snapshot.data.length == i && !b){
                                print('no access');
                                _showMyDialog();
                              }
                              print(i);
                              i++;
                             }

                          },
                        ),
                        SeassionCard(
                          seassionNum: 3,
                          sessionName: "Dysortho",
                          press: () {
                            var idDysortho= "6088d462079cb400154a37e1";
                            var i =1;
                            bool b = false;
                            for (var item in snapshot.data){
                              if (item.idExercice == idDysortho) {
                                b=true;
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return Levels();
                                    }),
                                  );
                                });

                              } else if (snapshot.data.length == i && !b){
                                print('no access');
                                _showMyDialog();
                              }
                              print(i);
                              i++;
                            }

                          },
                        ),

                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Meditation",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.all(10),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 17),
                            blurRadius: 23,
                            spreadRadius: -13,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/Meditation_women_small.svg",
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Basic 2",
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                                Text("Start your deepen you practice")
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/Lock.svg"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}

class SeassionCard extends StatelessWidget {
  final int seassionNum;
  final String sessionName;
  final bool isDone;
  final Function press;
  const SeassionCard({
    Key key,
    this.seassionNum,
    this.sessionName,
    this.isDone = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 -
              10, // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press ,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: isDone ? kBlueColor : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: isDone ? Colors.white : kBlueColor,
                      ),
                    ),

                    SizedBox(width: 10),
                    Text(
                      "$sessionName",
                      style: Theme.of(context).textTheme.subtitle,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
