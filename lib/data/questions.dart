import 'package:orthophoniste/models/option.dart';
import 'package:orthophoniste/models/question.dart';

final questions = [
  Question(
    text: 'Which planet is the hottest in the solar system?',
    options: [
      Option(code: 'A', text: 'assets/cheval.jpg', isCorrect: false),
      Option(code: 'A', text: 'assets/elephant.jpg', isCorrect: false),
      Option(code: 'B', text: 'assets/chat.jpg', isCorrect: true),
      Option(code: 'C', text: 'assets/ours.jpg', isCorrect: false),
    ],
    solution: 'Venus is the hottest planet in the solar system',
    sound: 'cat.mp3',
    number: 1,
  ),
  Question(
    text: 'How many molecules of oxygen does ozone have?',
    options: [
      Option(code: 'A', text: 'assets/chat.jpg', isCorrect: false),
      Option(code: 'B', text: 'assets/girafe.jpg', isCorrect: false),
      Option(code: 'C', text: 'assets/loup.jpg', isCorrect: false),
      Option(code: 'D', text: 'assets/chien.jpg', isCorrect: true),
    ],
    solution: 'Ozone have 3 molecules of oxygen',
    sound: 'dog.wav',
    number: 2,
  ),
  Question(
    text: 'What is the symbol for potassium?',
    options: [
      Option(code: 'A', text: 'assets/ours.jpg', isCorrect: false),
      Option(code: 'B', text: 'assets/tigre.jpg', isCorrect: false),
      Option(code: 'C', text: 'assets/poisson.jpg', isCorrect: false),
      Option(code: 'D', text: 'assets/elephant.jpg', isCorrect: true),
    ],
    solution: 'The symbol for potassium is K',
    sound: 'elephant.wav',
    number: 3,
  ),
  Question(
    text:
        'Which of these plays was famously first performed posthumously after the playwright committed suicide?',
    options: [
      Option(code: 'A', text: 'assets/lion.jpg', isCorrect: true),
      Option(code: 'B', text: 'assets/loup.jpg', isCorrect: false),
      Option(code: 'C', text: 'assets/lapin.jpg', isCorrect: false),
      Option(code: 'D', text: 'assets/zebre.jpg', isCorrect: false),
    ],
    solution: '4.48 Psychosis is the correct answer for this question',
    sound: 'lion.wav',
    number: 4,
  ),
  Question(
    text: 'What year was the very first model of the iPhone released?',
    options: [
      Option(code: 'A', text: 'assets/girafe.jpg', isCorrect: false),
      Option(code: 'B', text: 'assets/poisson.jpg', isCorrect: false),
      Option(code: 'C', text: 'assets/loup.jpg', isCorrect: true),
      Option(code: 'D', text: 'assets/zebre.jpg', isCorrect: false),
    ],
    solution: 'iPhone was first released in 2007',
    sound: 'wolf.wav',
    number: 5,
  ),
];
