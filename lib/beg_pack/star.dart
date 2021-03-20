import 'package:flutter/material.dart';

class MyStar extends StatelessWidget {
  int number;

  MyStar({this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/images_beg/star' + number.toString() + '.png'),
    );
  }
}
