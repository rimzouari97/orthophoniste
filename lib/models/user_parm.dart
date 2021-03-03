import 'package:flutter/foundation.dart';

class UserParam{
  String name;
  String email;
  String password;
  String tpye;

  UserParam({@required this.name,
             @required this.email,
             @required this.password,
             @required this.tpye});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "tpye": tpye,
    };
  }
}