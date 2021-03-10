import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/Welcome/welcome_screen.dart';
import 'package:orthophoniste/backend/backHome.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/services/user_service.dart';

import 'Screens/Home/home.dart';
import 'Screens/Home/level1/work1.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => UserService());
}

void main() {
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
        primaryColor:  kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
      //home: backHome(),
    );
  }
}
