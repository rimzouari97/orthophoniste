import 'package:flutter/material.dart';
import 'package:orthophoniste/Screens/Home/level1/work1.dart';
import 'package:orthophoniste/Screens/Welcome/welcome_screen.dart';
import 'package:orthophoniste/backend/backHome.dart';
import 'package:orthophoniste/constants.dart';


void main() => runApp(MyApp());

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
    // home: Home(),
      home: WelcomeScreen(),
        //home: backHome(),
    );
  }
}
