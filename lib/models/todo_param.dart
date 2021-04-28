import 'package:flutter/foundation.dart';

class ToDoParam{
  String id;
  String idUser;
  String idExercice;
  String AvgScore;


  ToDoParam({ this.id,
    this.AvgScore,
    this.idExercice,
    this.idUser,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id":id,
      "idUser": idUser,
      "idExercice": idExercice,
      "AvgScore": AvgScore,
    };
  }
}