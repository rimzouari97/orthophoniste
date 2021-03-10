import 'dart:math';
import 'package:flutter/material.dart';

class MyBoy extends StatelessWidget {
  final int boySpriteCount; // between 1~2
  final String boyDirection;
  final int attackBoySpriteCount;
  final bool underAttack;
  final bool currentlyLeveling;
  final bool smile;

  MyBoy({
    this.boySpriteCount,
    this.boyDirection,
    this.attackBoySpriteCount,
    this.currentlyLeveling,
    this.underAttack,
    this.smile,
  });

  @override
  Widget build(BuildContext context) {
    int directionAsInt = 1;

    if (boyDirection == 'right') {
      directionAsInt = 1;
    } else if (boyDirection == 'left') {
      directionAsInt = 0;
    } else {
      directionAsInt = 1;
    }

    if (smile == true) {
      return Container(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi * directionAsInt),
          child: Image.asset(
            'assets/images_beg/boy2.png',
          ),
        ),
      );
    } else if (attackBoySpriteCount == 0) {
      return Container(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi * directionAsInt),
          child: Image.asset(
            'assets/images_beg/standboy' +
                (boySpriteCount % 2 + 1).toString() +
                '.png',
            color: underAttack
                ? Colors.red
                : (currentlyLeveling ? Colors.yellow[200] : null),
          ),
        ),
      );
    } else {
      return Container(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi * directionAsInt),
          child: Image.asset(
            'assets/images_beg/attackboy' + (attackBoySpriteCount).toString() + '.png',
          ),
        ),
      );
    }
  }
}
