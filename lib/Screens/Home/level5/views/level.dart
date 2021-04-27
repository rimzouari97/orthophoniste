import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:orthophoniste/Screens/Home/level5/data/data.dart';
import 'package:orthophoniste/Screens/Home/level5/styles/styles.dart';
import 'package:orthophoniste/Screens/Home/level5/views/game.dart';





class Levels extends StatelessWidget {
  const Levels({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            SizedBox(height: 20),
            Neumorphic(
              child: AppBar(
                iconTheme: IconThemeData.fallback(),
                backgroundColor: Colors.grey[300],

                title: Text(
                  "   Dysorthographie",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              style: NeumorphicStyle(
                  depth: -8
              ),
            ),
            Spacer(
              flex: 1,
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
                            ? Colors.amber[400]
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
