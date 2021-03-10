import 'package:flutter/material.dart';
import 'package:orthophoniste/models/category.dart';
import 'package:orthophoniste/models/option.dart';
import 'package:orthophoniste/models/question.dart';
import 'package:orthophoniste/page/options_widget.dart';
import 'package:audioplayers/audio_cache.dart';

class QuestionsWidget extends StatelessWidget {
  final Category category;
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final ValueChanged<Option> onClickedOption;

  const QuestionsWidget({
    Key key,
    @required this.category,
    @required this.controller,
    @required this.onChangedPage,
    @required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PageView.builder(
        onPageChanged: onChangedPage,
        controller: controller,
        itemCount: category.questions.length,
        itemBuilder: (context, index) {
          final question = category.questions[index];

          return buildQuestion(question: question);
        },
      );

  Widget buildQuestion({
    @required Question question,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            FlatButton(
              color: Colors.teal,
              onPressed: () {
                final player = AudioCache();
                player.play(question.sound);
                // playsound(soundnumber);
              },
              child: Text('Entendre le son'),
            ),
            //Text(
            // question.text,
            //  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            //  ),
            SizedBox(height: 8),
            Text(
              'Choisissez votre réponse ci-dessous',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
            SizedBox(height: 32),
            Text(
              //  "scoore: " + question.scoore.toString(),
              "Numéro de question: " + question.number.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 32),
            Expanded(
              child: OptionsWidget(
                question: question,
                onClickedOption: onClickedOption,
              ),
            ),
          ],
        ),
      );
}
