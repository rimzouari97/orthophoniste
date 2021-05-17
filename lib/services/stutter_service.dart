import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:orthophoniste/backend/dropdowe_mune_exercice.dart';
import 'package:orthophoniste/beg_pack/Beg.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/exercice.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/todo_param.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:http/http.dart' as http;
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StutterService {
  static const API = BASE_URL + "stutter/";

  SharedPref pref = SharedPref();

  Future<APIResponse<List<User>>> getStutterProgress(String user) {
    //  print("jsonData");
    const uri = API + "stutter";
    return http.get(uri + "?idUser=" + user).then((data) {
      print(data.body);

      if (data.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(data.body);
        print("code = " + data.statusCode.toString());

        FullSampleHomePage.stutterProgress = int.parse(jsonData["level"]);
      }
      return APIResponse<List<User>>(errer: true, errorMessage: " An errer 01");
    }).catchError((_) =>
        APIResponse<List<User>>(errer: true, errorMessage: " An errer 02"));
  }

  static Future<APIResponse<String>> saveStutterProgress(int nprog) async {
    //print(item.email+' '+item.password);
    if (nprog > FullSampleHomePage.stutterProgress) {
      FullSampleHomePage.stutterProgress = nprog;
    }
    String item = FullSampleHomePage.stutterProgress.toString();

    SharedPreferences _prefs = await SharedPreferences.getInstance();

    String cUserId = _prefs.getString("UserId");

    return http
        .post(API + "stutter",
            headers: headers,
            body: json.encode({"progress": item, "idUser": cUserId}))
        .then((data) {
      if (data.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(data.body);
        var item = jsonData;
        print(item);
        // print(jsonData["hasOrtho"]);

        return APIResponse<String>(data: null);
      }
      return APIResponse<String>(errer: true, errorMessage: " An errer 11");
    }).catchError((_) =>
            APIResponse<String>(errer: true, errorMessage: " An errer 12"));
  }
}
