import 'package:flutter/material.dart';
import 'dart:math';
import 'package:orthophoniste/beg_pack/final_level.dart';
import 'package:orthophoniste/beg_pack/level2.dart';
import 'package:orthophoniste/beg_pack/level1.dart';
import 'package:orthophoniste/beg_pack/level3.dart';
import 'package:orthophoniste/beg_pack/level4.dart';
import 'package:orthophoniste/beg_pack/level5.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';

class Beg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FullSampleHomePage(),
    );
  }
}

class FullSampleHomePage extends StatelessWidget {
  static int stutterProgress = 0;

  Widget _buildButton({String text, VoidCallback onClick}) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 10,
      ),
      style: NeumorphicStyle(
        color: NeumorphicColors.darkBackground,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        shape: NeumorphicShape.flat,
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
          color: NeumorphicColors.accent,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      )),
      onPressed: onClick,
    );
  }

  String getLevelName(String _level) {
    String lname = "Level " + _level;
    if (int.parse(_level) > stutterProgress) {
      lname = "🔒 " + lname;
    }
    return lname;
  }

  bool levelLocked(int lvl) {
    if (lvl <= stutterProgress) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(depth: 8),
      child: Scaffold(
        backgroundColor: Colors.green[50],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text("Stutterless Game",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 35,
                          color: NeumorphicTheme.defaultTextColor(context))),
                  SizedBox(
                    height: 20,
                  ),
                  Lottie.network(
                      'https://assets10.lottiefiles.com/packages/lf20_RItkEz.json'),
                  SizedBox(
                    height: 50,
                  ),
                  _buildButton(
                    text: getLevelName('1'),
                    onClick: () {
                      if (levelLocked(1)) return;
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Level1();
                      }));
                    },
                  ),
                  SizedBox(height: 20),
                  _buildButton(
                    text: getLevelName('2'),
                    onClick: () {
                      if (levelLocked(2)) return;
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Level2();
                      }));
                    },
                  ),
                  SizedBox(height: 20),
                  _buildButton(
                      text: getLevelName('3'),
                      onClick: () {
                        if (levelLocked(3)) return;
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Level3();
                        }));
                      }),
                  SizedBox(height: 20),
                  _buildButton(
                      text: getLevelName('4'),
                      onClick: () {
                        if (levelLocked(4)) return;
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Level4();
                        }));
                      }),
                  SizedBox(height: 20),
                  _buildButton(
                      text: getLevelName('5'),
                      onClick: () {
                        if (levelLocked(5)) return;
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Level5();
                        }));
                      }),
                  SizedBox(height: 20),
                  _buildButton(
                      text: getLevelName('6'),
                      onClick: () {
                        if (levelLocked(6)) return;
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return FinalLevel();
                        }));
                      }),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
