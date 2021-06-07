import 'package:http/http.dart' as http;
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/exercice.dart';
import 'package:orthophoniste/models/todo_param.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'dart:convert';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:orthophoniste/models/done.dart';

class DoneService {
  //static const API = "http://172.16.76.38:3000/" + "done/";
  static const API = BASE_URL + "done/";

  Future<APIResponse<Done>> addEx(Done item) {
    print(json.encode(item.toJson()));
    return http
        .post(API + "add", headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      print(data.body);
      if (data.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(data.body);

        print(jsonData);
        var item = jsonData["exercice"];
        final done = Done(id: item["_id"], exerciceName: item["exerciceName"]);
        return APIResponse<Done>(
            data: done, errer: false, errorMessage: "jsonData[message]");
      }
      return APIResponse<Done>(errer: true, errorMessage: " An errer 1");
    }).catchError((_) =>
            APIResponse<Done>(errer: true, errorMessage: " Opps server Errer"));
  }

  Future<List<Done>> getAllByIdDone(Done item) {
    //  print(json.encode(item.toJson()));
    var parm = {"id": item.id};
    print(json.encode(parm));
    return http
        .post(BASE_URL + "done/" + "getByIdP",
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString());
      // print(data.body);
      List<Done> list = <Done>[];
      if (data.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(data.body);

        print(jsonData);

        for (var item in jsonData.values.last) {
          print("item");
          print(item);

          Done done = Done(
              id: item["_id"],
              score: item['score'],
              iteration: item["iteration"],
              idUser: item["idUser"],
              idToDo: item["idToDo"],
              idExercice: item["idExercice"],
              exerciceName: item["exerciceName"]);

          list.add(done);
        }
      }
      return list;
    });
  }

  //SharedPref pref = SharedPref();

  Future<APIResponse<List<Done>>> getDoneList() {
    //  print("jsonData");
    const uri = API + "list";
    return http.get(uri).then((data) {
      //  print(data);
      if (data.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(data.body);
        final dones = <Done>[];
        //pref.addUserToken(jsonData["token"]);
        for (var item in jsonData.values.first) {
          final done = Done(
              id: item["_id"],
              score: item['score'],
              iteration: item["iteration"],
              idUser: item["idUser"],
              idToDo: item["idToDo"],
              idExercice: item["idExercice"],
              exerciceName: item["exerciceName"]);
          dones.add(done);
        }

        return APIResponse<List<Done>>(data: dones);
      }
      return APIResponse<List<Done>>(errer: true, errorMessage: " An errer 1");
    }).catchError((_) =>
        APIResponse<List<Done>>(errer: true, errorMessage: " An errer 2"));
  }

  Future<List<ToDoParam>> getToDoListByIdP(Done item) {
    //  print(json.encode(item.toJson()));
    var parm = {"idUser": item.idUser};
    print(json.encode(parm));
    return http
        .post(BASE_URL + "todo/" + "getByIdUser",
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString());
      print(data.body);
      List<ToDoParam> list = <ToDoParam>[];
      if (data.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(data.body);

        print(jsonData);

        for (var item in jsonData.values.last) {
          print("item");
          print(item);

          ToDoParam done = ToDoParam(
              id: item["_id"],
              idUser: item["idUser"],
              idExercice: item["idExercice"],
              AvgScore: item["AvgScore"]);

          list.add(done);
        }
      }
      return list;
    });
  }

  /////////////get last score/////////////

  Future <Done> getLastScore(Done item) {
    //  print(json.encode(item.toJson()));
    //var parm = {"id": item.id};
    //print(json.encode(parm));
    return http
        .post(BASE_URL + "done/" + "getscore",
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString());
      //data response of server
      // print(data.body);
      List<Done> list = <Done>[];
      if (data.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(data.body);

        print(jsonData);

        for (var item in jsonData.values.last) {
          print("item");
          print(item);
          //serialisation
          Done done = Done(
              id: item["_id"],
              score: item['score'],
              iteration: item["iteration"],
              idUser: item["idUser"],
              idToDo: item["idToDo"],
              idExercice: item["idExercice"],
              exerciceName: item["exerciceName"]);

          list.add(done);
        }
      }
      return list.last;
    });
  }

//////////////////////////**








  Future <List<Done>> getState (ToDoParam item) {
      print(json.encode(item.toJson()));
    var parm = {"id": item.id};
    //print(json.encode(parm));
    return http
        .post(BASE_URL + "done/" + "getscore",
        headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString());
      // print(data.body);
      List<Done> list = <Done>[];
      if (data.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(data.body);

       // print(jsonData);

        for (var item in jsonData.values.last) {
       //   print("item");
       //   print(item);

          Done done = Done(
              id: item["_id"],
              score: item['score'],
              iteration: item["iteration"],
              idUser: item["idUser"],
              idToDo: item["idToDo"],
              idExercice: item["idExercice"],
              exerciceName: item["exerciceName"]);

          list.add(done);
        }
      }
      return list;
    });
  }

}
