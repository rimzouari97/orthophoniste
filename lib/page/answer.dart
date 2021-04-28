import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 100,

        child: RaisedButton(
          //color: Color(0xFF00E676),
          color: Colors.white,
          textColor: Colors.white,
          //child: Text(questions[questionIndex]['answers']),
          child: Image(
            image: AssetImage(answerText),
          ),
          onPressed: selectHandler,
        ), //RaisedButton
      ),
    ); //Container
  }
}
