import 'package:flutter/material.dart';
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
                    text: "LEVEL 1",
                    onClick: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Level1();
                      }));
                    },
                  ),
                  SizedBox(height: 20),
                  _buildButton(
                    text: "LEVEL 2",
                    onClick: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Level2();
                      }));
                    },
                  ),
                  SizedBox(height: 20),
                  _buildButton(
                      text: "LEVEL 3",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Level3();
                        }));
                      }),
                  SizedBox(height: 20),
                  _buildButton(
                      text: "LEVEL 4",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Level4();
                        }));
                      }),
                  SizedBox(height: 20),
                  _buildButton(
                      text: "LEVEL 5",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Level5();
                        }));
                      }),
                  SizedBox(height: 20),
                  _buildButton(
                      text: "FINAL LEVEL",
                      onClick: () {
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
