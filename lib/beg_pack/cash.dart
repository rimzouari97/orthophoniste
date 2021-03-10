import 'package:flutter/material.dart';

class MyCash extends StatelessWidget {
  final int cashSpriteStep;

  MyCash({this.cashSpriteStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images_beg/cash' + (cashSpriteStep % 4 + 1).toString() + '.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
