import 'package:flutter/cupertino.dart';

import 'option.dart';

class Question {
  final String text;
  final List<Option> options;
  final String solution;
  bool isLocked;
  Option selectedOption;
  final String sound;
  int number;

  Question({
    @required this.text,
    @required this.options,
    @required this.solution,
    @required this.sound,
    @required this.number,
    this.isLocked = false,
    this.selectedOption,
  });
}
