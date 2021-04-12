import 'package:http/http.dart' as http;
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'dart:convert';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:orthophoniste/models/done.dart';

class DoneService {
  static const API = BASE_URL + "done/";

  Future<APIResponse<Done>> addEx(Done item) {
    print(json.encode(item.toJson()));
    return http
        .post(API + "add", headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      print(data.body);
      if (data.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(data.body);

        var item = jsonData["exercice"];
        final done = Done(id: item["_id"], exerciceName: item["exerciceName"]);
        return APIResponse<Done>(
            data: done, errer: false, errorMessage: "jsonData[message]");
      }
      return APIResponse<Done>(errer: true, errorMessage: " An errer 1");
    }).catchError((_) =>
            APIResponse<Done>(errer: true, errorMessage: " Opps server Errer"));
  }
}
