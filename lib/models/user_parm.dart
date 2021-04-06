import 'package:flutter/foundation.dart';

class UserParam{
  String name;
  String email;
  String password;
  String type;
  String token;
  int code;
  String codeV;
  String phone;
  String id;
  String score;

  UserParam({ this.id,
              this.name,
              this.email,
              this.password,
              this.type,
              this.codeV,
              this.phone});

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "name": name,
      "email": email,
      "password": password,
      "type": type,
      "code":code,
      "token":token,
      "codeV":codeV
    };
  }
}