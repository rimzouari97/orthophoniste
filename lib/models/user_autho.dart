import 'package:flutter/foundation.dart';

class UserAutho{
  String email;
  String password;

  UserAutho({
    @required this.email,
    @required this.password
    });

  Map<String, dynamic> toJson() {
    return {

      "email": email,
      "password": password,

    };
  }
}