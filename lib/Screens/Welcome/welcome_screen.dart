import 'package:flutter/material.dart';
import 'package:orthophoniste/Screens/Welcome/components/body.dart';
import 'package:orthophoniste/Screens/Welcome/components/test-app.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // body: Body(),
      body: TestApp(),
    );
  }
}
