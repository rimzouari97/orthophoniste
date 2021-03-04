import 'package:orthophoniste/models/option.dart';
import 'package:orthophoniste/models/question.dart';

final questions = [
  Question(
    text: 'Which planet is the hottest in the solar system?',
    options: [
      Option(code: 'A', text: 'singe', isCorrect: false),
      Option(code: 'B', text: 'chat', isCorrect: true),
      Option(code: 'C', text: 'ours ', isCorrect: false),
      Option(code: 'D', text: 'kangourou', isCorrect: false),
    ],
    solution: 'Venus is the hottest planet in the solar system',
    sound: 'cat.mp3',
  ),
  Question(
    text: 'How many molecules of oxygen does ozone have?',
    options: [
      Option(code: 'A', text: 'chat', isCorrect: false),
      Option(code: 'B', text: 'ours', isCorrect: false),
      Option(code: 'C', text: 'lapin', isCorrect: false),
      Option(code: 'D', text: 'chien', isCorrect: true),
    ],
    solution: 'Ozone have 3 molecules of oxygen',
    sound: 'dog.wav',
  ),
  Question(
    text: 'What is the symbol for potassium?',
    options: [
      Option(code: 'A', text: 'lapin', isCorrect: false),
      Option(code: 'B', text: 'singe', isCorrect: false),
      Option(code: 'C', text: 'lion', isCorrect: false),
      Option(code: 'D', text: 'éléphant', isCorrect: true),
    ],
    solution: 'The symbol for potassium is K',
    sound: 'elephant.wav',
  ),
  Question(
    text:
        'Which of these plays was famously first performed posthumously after the playwright committed suicide?',
    options: [
      Option(code: 'A', text: 'lion', isCorrect: true),
      Option(code: 'B', text: 'lapin', isCorrect: false),
      Option(code: 'C', text: "chien", isCorrect: false),
      Option(code: 'D', text: "canard", isCorrect: false),
    ],
    solution: '4.48 Psychosis is the correct answer for this question',
    sound: 'lion.wav',
  ),
  Question(
    text: 'What year was the very first model of the iPhone released?',
    options: [
      Option(code: 'A', text: 'canard', isCorrect: false),
      Option(code: 'B', text: 'lion', isCorrect: false),
      Option(code: 'C', text: 'loup', isCorrect: true),
      Option(code: 'D', text: 'poisson', isCorrect: false),
    ],
    solution: 'iPhone was first released in 2007',
    sound: 'wolf.wav',
  ),
];
