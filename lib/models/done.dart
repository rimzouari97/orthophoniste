import 'package:flutter/foundation.dart';

class Done {
  String id;
  String exerciceName;
  String iteration;
  String score;
  String idUser;
  String idExercice;
  String idToDo;

  Done(
      {this.id,
      this.exerciceName,
      this.idExercice,
      this.idToDo,
      this.idUser,
      this.iteration,
      this.score});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "score": score,
      "iteration": iteration,
      "idUser": idUser,
      "idToDo": idToDo,
      "idExercice": idExercice,
      "exerciceName": exerciceName
    };
  }
}
