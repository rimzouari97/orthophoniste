import 'package:flutter/foundation.dart';

class ToDoParam{
  String id;
  String idUser;
  String idExercice;
  String AvgScore;
  String idOrtho;


  ToDoParam({ this.id,
    this.AvgScore,
    this.idExercice,
    this.idUser,
    this.idOrtho
  });

  Map<String, dynamic> toJson() {
    return {
      "_id":id,
      "idUser": idUser,
      "idExercice": idExercice,
      "AvgScore": AvgScore,
      "idOrtho" : idOrtho
    };
  }
}