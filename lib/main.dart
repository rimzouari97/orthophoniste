import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:orthophoniste/Screens/Home/level3/details_screen2.dart';
import 'package:orthophoniste/Screens/Home/level3/pages/game.dart';
import 'package:orthophoniste/Screens/Home/level4/screens/bottom_navigation_screen.dart';
import 'package:orthophoniste/Screens/Home/screens/details_screen.dart';
import 'package:orthophoniste/Screens/Login/components/background.dart';
import 'package:orthophoniste/Screens/Login/hasOrth.dart';
import 'package:orthophoniste/Screens/Login/login_screen.dart';
import 'package:orthophoniste/Screens/Profile/profile_screen.dart';
import 'package:orthophoniste/Screens/Welcome/welcome_screen.dart';
import 'package:orthophoniste/backend/backHome.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/score.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:orthophoniste/services/done_service.dart';
import 'package:orthophoniste/services/stutter_service.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/Home/home.dart';
import 'Screens/Home/level1/work1.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => UserService());
  GetIt.I.registerLazySingleton(() => StutterService());
    GetIt.I.registerLazySingleton(() => DoneService());
}

//void main() {
// setupLocator();
//  runApp(MyApp());
//}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ScoreAdapter());
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  StutterService get stutterservice => GetIt.I<StutterService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {'/game': (context) => Game()},
      //home :ProfileScreen(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String hasOr;



  String currentUserId = "";

  Future<String> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        debugPrint('Step 2, fetch data');
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        SharedPref pref = SharedPref();
        currentUserId = _prefs.getString("UserId");
        hasOr = _prefs.getString('HasOrtho');
        print('hasOr');
        print(hasOr);
        return pref.getUserType();
        //return false;
      });

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          print("test 500");
          print(snapshot.hasData);
          if (snapshot.hasData) {
            if (snapshot.data == "patient") {
              if (hasOr == "false") {
                return HasOrth();
              }
              return HomeScreen();
            } else {
              return backHome();
            }
          } else if (snapshot.data == null) {
            return WelcomeScreen();
          } else {
            // We can show the loading view until the data comes back.
            debugPrint('Step 1, build loading widget');
            print("test 5554");
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
                width: 60,
                height: 60,
              ),
              // Padding(
              //   padding: EdgeInsets.all(50 ),
              //  child: Text('Awaiting result...'),
              //   )
            );
          }
        },
      );
}
