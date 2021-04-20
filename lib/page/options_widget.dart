import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:orthophoniste/models/option.dart';
import 'package:orthophoniste/models/question.dart';
import 'package:orthophoniste/widged/utils.dart';

class OptionsWidget extends StatefulWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key key,
    @required this.question,
    @required this.onClickedOption,
  }) : super(key: key);

  @override
  _OptionsWidgetState createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  @override
  Widget build(BuildContext context) => ListView(
        physics: BouncingScrollPhysics(),
        children: Utils.heightBetween(
          widget.question.options
              .map((option) => buildOption(context, option))
              .toList(),
          height: 8,
        ),
      );

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, widget.question);

    return GestureDetector(
      onTap: () => widget.onClickedOption(option),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            buildAnswer(option),
            buildSolution(widget.question.selectedOption, option),
          ],
        ),
      ),
    );
  }

  Widget buildAnswer(Option option) => Container(
        height: 50,
        child: Row(children: [
          Text(
            option.code,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(width: 12),
          Image(image: AssetImage(option.text)),
        ]),
      );

  Widget buildSolution(Option solution, Option answer) {
    if (solution == answer) {
      return Text(
        '',
        //question.solution,
        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      );
    } else {
      return Container();
    }
  }

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;

    if (!isSelected) {
      return Colors.grey.shade200;
    } else {
      if (option.isCorrect) {
        print('correct');
        player.play(question.sound);
        //player.play('success.mp3');
        return Colors.green;
      } else {
        player.play('wrong.mp3');
        print('false!!!!');
        return Colors.red;
      }
      //return option.isCorrect ? Colors.green : Colors.red;
    }
  }
}

final player = AudioCache();
