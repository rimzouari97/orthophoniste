import 'package:flutter/foundation.dart';

class OrthoParam{
  String id;
  String nameP;
  String idP;
  String idOrtho;
  String valid;

  OrthoParam({ this.id,
    this.nameP,
    this.idOrtho,
    this.idP,
    this.valid});

  Map<String, dynamic> toJson() {
    return {
      "_id":id,
      "namep": nameP,
      "idP": idP,
      "idOrtho": idOrtho,
      "valid": valid,
    };
  }
}