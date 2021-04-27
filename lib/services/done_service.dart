import 'package:http/http.dart' as http;
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/user_parm.dart';
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

  Future<List<Done>> getByIdEx(Done item){
    //  print(json.encode(item.toJson()));
    var parm ={"id" :item.id};
    print(json.encode(parm));
    return http.post(BASE_URL+"done/"+"getById" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString() );
      // print(data.body);
      List<Done>  list = <Done>[];
      if(data.statusCode == 200){

        Map<String, dynamic> jsonData = json.decode(data.body);

        print(jsonData);

        for(var item in jsonData.values.last ){

          print("item");
          print(item);


          Done done = Done(
              score: item["score"],
              id: item["_id"],
              iteration: item['iteration'],
              idUser: item["idUser"],
              idToDo: item["idToDo"],
              idExercice: item["idExercice"],
              exerciceName: item["exerciceName"]
          );

          list.add(done);
        }


      }
      return list;
    });
  }


}
