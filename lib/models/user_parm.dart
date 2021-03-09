import 'package:flutter/foundation.dart';

class UserParam{
  String name;
  String email;
  String password;
  String type;

  UserParam({@required this.name,
             @required this.email,
             @required this.password,
             @required this.type});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "type": type,
    };
  }
}