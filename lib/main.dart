import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:orthophoniste/Screens/Login/components/background.dart';
import 'package:orthophoniste/Screens/Profile/profile_screen.dart';
import 'package:orthophoniste/Screens/Welcome/welcome_screen.dart';
import 'package:orthophoniste/backend/backHome.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/score.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/Home/home.dart';
import 'Screens/Home/level1/work1.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => UserService());
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Flutter Auth',
      theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
     ),

       // home :ProfileScreen(),
      home: MyHomePage(),
     );

  }

}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: fetchData(),
    builder: (context, snapshot) {
      if(snapshot.hasData) {
           if (snapshot.data == true) {
                return HomeScreen() ;
           } else  {
              return  WelcomeScreen();
        }
      }else {
         // We can show the loading view until the data comes back.
          debugPrint('Step 1, build loading widget');
          return Center( child:

            SizedBox(
              child: CircularProgressIndicator(backgroundColor: Colors.white,),
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

  Future<bool> fetchData() => Future.delayed(Duration(microseconds: 100), () {
    debugPrint('Step 2, fetch data');
    SharedPref pref = SharedPref();
    return pref.isConnect();
    //return false;
  });
}
