import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/models/done.dart';
import 'package:orthophoniste/services/done_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Score {
  String level;
  int score = 0;
  Score({ @required this.level });

  String _idUser;

  DoneService get service => GetIt.I<DoneService>();

  Future<bool> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        debugPrint('Step 2, fetch data');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        _idUser = preferences.getString('UserId');

        return true;
      });

  Future<List<dynamic>> getScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String scoresString = prefs.getString(this.level);

    if(scoresString == null) {
      scoresString = "[]";
    }

    return json.decode(scoresString);
  }

  Future<void> addScore(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<dynamic> scoreList = await getScore();

    if(!scoreList.contains(value)) {
      scoreList.add(value);
      score += 10;
    }
    print('end of the game');
    print(score);
    print(_idUser);
    Done done = Done(
        idExercice: "6088d433079cb400154a37df",
        exerciceName: "dyslexie lexicale game",
        idToDo: "mm",
        score: score.toString(),
        idUser: _idUser);
    service.addEx(done).then((result) => {
      print(result.data),
      if (!result.errer) {print(result.errorMessage)}
    });
    String updatedScoreString = json.encode(scoreList);

    prefs.setString(this.level, updatedScoreString);

  }


}