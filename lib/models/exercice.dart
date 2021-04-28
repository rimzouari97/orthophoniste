import 'package:flutter/foundation.dart';

class Exercice{
  String id;
  String name;
  String category;
  String type;
  String score;
  String niveau;

  Exercice({ this.id,
    this.name,
    this.type,
    this.score,
    this.category,
    this.niveau
  });

  Map<String, dynamic> toJson() {
    return {
      "_id":id,
      "name": name,
      "score": score,
      "category": category,
      "type": type,
      "niveau":niveau
    };
  }
}