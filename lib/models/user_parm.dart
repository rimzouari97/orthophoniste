import 'package:flutter/foundation.dart';

class UserParam{
  String name;
  String email;
  String password;
  String type;
  String token;
  String code;
  String codeV;
  String phone;
  String id;
  String score;
  String hasOrtho;

  UserParam({ this.id,
              this.name,
              this.email,
              this.password,
              this.type,
              this.codeV,
              this.code,
              this.phone,
              this.hasOrtho});

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "name": name,
      "email": email,
      "password": password,
      "type": type,
      "code":code,
      "token":token,
      "codeV":codeV,
      "hasOrtho":hasOrtho
    };
  }
}