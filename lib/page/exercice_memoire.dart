import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orthophoniste/Screens/Home/constants.dart';
import 'package:orthophoniste/Screens/draggable_puzzle.dart';
import 'package:orthophoniste/models/done.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:orthophoniste/Screens/Home/widgets/bottom_nav_bar.dart';
import 'package:orthophoniste/Screens/Home/widgets/search_bar.dart';
import 'package:orthophoniste/Screens/colorgame.dart';
import 'package:orthophoniste/page/main_quizz.dart';
import 'package:orthophoniste/data/categories.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/services/done_service.dart';
import 'package:orthophoniste/models/todo_param.dart';

import 'category_page.dart';
import 'category_page.dart';
import 'options_widget.dart';

class ExerciceConcentration extends StatefulWidget {
  @override
  _Quiz createState() => _Quiz();
}

class _Quiz extends State<ExerciceConcentration> {
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
          title: Text('Alert d acces'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("vous n'avez pas acces"),
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
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<List<ToDoParam>> snapshot) {
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
                          width: size.width *
                              .6, // it just take 60% of total width
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
                            /* SeassionCard(
                          seassionNum: 1,
                          isDone: true,
                          seassionName: "Quiz",
                          press: () {
                            setState(() {
                              build(context);
                              //CategoryPage(category: categories.last);
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return CategoryPage(category: categories.last);
                              }),
                            );
                          },
                        ),*/
                            /*SeassionCard(
                          seassionNum: 2,
                          press: () {
                            */ /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return HomePage();
                              }),
                            );*/ /*
                          },
                        ),*/
                            SeassionCard(
                              seassionNum: 3,
                              seassionName: "Couleurs",
                              press: () {
                                var idcolor = "6074ab5b82c71b0015918da2";
                                var i = 1;
                                bool b = false;
                                for (var item in snapshot.data) {
                                  if (item.idExercice == idcolor) {
                                    b = true;
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return ColorGame();
                                        }),
                                      );
                                    });
                                    // i++;
                                  } else if (snapshot.data.length == i && !b) {
                                    print('no acces');
                                    _showMyDialog();
                                  }
                                  print(i);
                                  i++;
                                }
                              },
                            ),
                            SeassionCard(
                              seassionNum: 4,
                              seassionName: "Forme",
                              press: () {
                                var idcolor = "6074abf282c71b0015918da3";
                                var i = 1;
                                print(snapshot.data.length);
                                bool b = false;
                                for (var item in snapshot.data) {
                                  if (item.idExercice == idcolor) {
                                    b = true;
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return DragPicture();
                                        }),
                                      );
                                    });
                                    //i++;
                                  } else if (snapshot.data.length == i && !b) {
                                    print(
                                        "vous n'avez pas le droit d'acceder a cet exercice car il n est pas encore affecter a vous");
                                    _showMyDialog();
                                  }
                                  print(i);
                                  i++;
                                }
                                //_showMyDialog();
                                //  print('no acces');
                              },
                            ),
                            SeassionCard(
                              seassionNum: 5,
                              seassionName: "Quizz 2",
                              press: () {
                                var idcolor = "6074b1a582c71b0015918da5";
                                var i = 1;
                                bool b = false;
                                for (var item in snapshot.data) {
                                  if (item.idExercice == idcolor) {
                                    b = true;
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return Myquizz();
                                        }),
                                      );
                                    });
                                    //i++;
                                  } else if (snapshot.data.length == i && !b) {
                                    print('no acces');
                                    _showMyDialog();
                                  }
                                  print(i);
                                  i++;
                                }
                              },
                            ),
                            /*SeassionCard(
                              seassionNum: 6,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return DragPicture();
                                  }),
                                );
                              },
                            ),*/
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Basic 2",
                                      style:
                                          Theme.of(context).textTheme.subtitle,
                                    ),
                                    Text("Start your deepen you practice")
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child:
                                    SvgPicture.asset("assets/icons/Lock.svg"),
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
  final bool isDone;
  final String seassionName;
  final Function press;
  const SeassionCard({
    Key key,
    this.seassionNum,
    this.seassionName,
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
              onTap: press,
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
                      //"Session $seassionNum",
                      " $seassionName",
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
