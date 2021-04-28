import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';
import 'package:audioplayers/audio_cache.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          color: Colors.teal,
          onPressed: () {
            final player = AudioCache();
            player.play(questions[questionIndex]['questionText']);
            // playsound(soundnumber);
          },
          child: Text('Entendre le son'),
        ),
        //Question(
        // questions[questionIndex]['questionText'],
        // ), //Question
        //Image(image: AssetImage(questions[questionIndex]['answers'])),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']), answer['text']);
        }).toList()
      ],
    ); //Column
  }
}
