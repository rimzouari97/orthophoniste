import 'package:flutter/material.dart';

import 'package:orthophoniste/Screens/Login/components/body.dart';
import 'package:orthophoniste/Screens/Login/components/bodyHas.dart';

class HasOrth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Scaffold(
        appBar: AppBar(
          title: Text("welcome to My App"),
        ),
        body:BodyHas()
      ),
    );
  }
}
