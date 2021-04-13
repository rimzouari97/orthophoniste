import 'package:flutter/material.dart';
import 'package:orthophoniste/Screens/Home/level5/data/data.dart';
import 'package:orthophoniste/Screens/Home/level5/styles/styles.dart';
import 'package:orthophoniste/Screens/Home/level5/views/game.dart';





class Levels extends StatelessWidget {
  const Levels({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: questions.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5, mainAxisSpacing: 5, crossAxisCount: 4),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => questions[index].unlock
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => Game(question: questions[index])))
                      : {},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: questions[index].unlock
                            ? Colors.blue[900]
                            : Colors.grey[500]),
                    child: Center(
                        child: Text('${questions[index].id + 1}',
                            style: mainTextStyle)),
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
