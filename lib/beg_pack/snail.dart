import 'dart:math';

import 'package:flutter/material.dart';

class BlueSnail extends StatelessWidget {
  final int snailSpriteCount; // between 1~4
  final String snailDirection;
  final int deadSnailSprite;
  int directionInt;

  BlueSnail({this.snailSpriteCount, this.snailDirection, this.deadSnailSprite});

  @override
  Widget build(BuildContext context) {
    if (snailDirection == 'left') {
      directionInt = 0; // means we don't need to turn direction
    } else {
      directionInt = 1; // means we need to turn pi radians.
    }

    if (deadSnailSprite == 0) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi * directionInt),
        child: Container(
          alignment: Alignment(0, 1),
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/images_beg/snailsprite/snail' +
                (snailSpriteCount % 4 + 1).toString() +
                '.png',
          ),
        ),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi * directionInt),
        child: Container(
          alignment: Alignment(0, 1),
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/images_beg/snailsprite/snaildie' +
                (deadSnailSprite).toString() +
                '.png',
          ),
        ),
      );
    }
  }
}
