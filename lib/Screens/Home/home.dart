import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/Home/level3/details_screen2.dart';
import 'package:orthophoniste/Screens/Home/level3/pages/home.dart';
import 'package:orthophoniste/Screens/Home/screens/details_screen.dart';
import 'package:orthophoniste/Screens/Home/widgets/bottom_nav_bar.dart';
import 'package:orthophoniste/Screens/Home/widgets/category_card.dart';
import 'package:orthophoniste/Screens/Home/widgets/search_bar.dart';
import 'package:orthophoniste/Screens/Welcome/welcome_screen.dart';
import 'package:orthophoniste/beg_pack/Beg.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/main.dart';
import 'package:orthophoniste/models/todo_param.dart';
import 'package:orthophoniste/page/exercice_memoire.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserService get service => GetIt.I<UserService>();
  List<ToDoParam> ToDoList = [];

  final Future<String> _name =
      Future<String>.delayed(const Duration(microseconds: 100), () {

    SharedPref pref = SharedPref();
    return pref.getUserName();
  });

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _name, //fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              bottomNavigationBar: BottomNavBar(),
              body: Stack(
                children: <Widget>[
                  Container(
                    // Here the height of the container is 45% of our total height
                    height: MediaQuery.of(context).size.height * .45,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5CEB8),
                      image: DecorationImage(
                        alignment: Alignment.centerLeft,
                        image:
                            AssetImage("assets/images/undraw_pilates_gpdb.png"),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(100.0)),
                              onPressed: () {},
                              child: Container(
                                alignment: Alignment.center,
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2BEA1),
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    SvgPicture.asset("assets/icons/menu.svg"),
                              ),
                            ),
                          ),
                          Text(
                            "Good Morning \n" + snapshot.data.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(fontWeight: FontWeight.w900),
                          ),
                          SearchBar(),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: .85,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              children: <Widget>[
                                CategoryCard(
                                  title: "Memory lessons",
                                  svgSrc: "assets/icons/brain.svg",
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return DetailsScreen();
                                      }),
                                    );
                                  },
                                ),
                                CategoryCard(
                                  title: "Stuttering lessons",
                                  svgSrc: "assets/icons/Excrecises.svg",
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return Beg();
                                      }),
                                    );
                                  },
                                ),
                                CategoryCard(
                                  title: "Concentration lessons",
                                  svgSrc: "assets/icons/Meditation.svg",
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return ExerciceConcentration();
                                      }),
                                    );
                                  },
                                ),
                                CategoryCard(
                                  title: "Learning lessons",
                                  svgSrc: "assets/icons/yoga.svg",
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return DetailsScreen2();
                                      }),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            // We can show the loading view until the data comes back.
            debugPrint('Step 3, build loading widget');
            // return CircularProgressIndicator();
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
                width: 60,
                height: 60,
              ),
            );
          }
        },
      );

  Future<String> fetchData() => Future.delayed(Duration(seconds: 1), () {
        debugPrint('Step 4, fetch data');
        SharedPref pref = SharedPref();
        return pref.getUserName();
      });
}
