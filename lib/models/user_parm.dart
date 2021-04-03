import 'package:flutter/foundation.dart';

class UserParam{
  String name;
  String email;
  String password;
  String type;
  String token;
  int code;
  String codeV;

  UserParam({@required this.name,
             @required this.email,
             @required this.password,
             @required this.type,
              this.codeV});

  Map<String, dynamic> toJson() {
    return {
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