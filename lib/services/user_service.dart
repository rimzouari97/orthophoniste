import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:orthophoniste/backend/dropdowe_mune_exercice.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/exercice.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/todo_param.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:http/http.dart'as http;
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/shared_preferences.dart';
class UserService {

  static  const API = BASE_URL+"users/";
  
  SharedPref pref = SharedPref();
  
 Future<APIResponse<List<User>>> getUsersList(){
    //  print("jsonData");
      const uri = API+"list";
   return http.get(uri)
       .then((data) {
   //  print(data);
         if(data.statusCode == 200){
           final Map<String, dynamic> jsonData = json.decode(data.body);
           final users = <User>[];
           pref.addUserToken(jsonData["token"]);
          for(var item in jsonData.values.first ){
             final user = User(
                 item['_id'],
                 item['name'],
                 item['email'],
                 item['type'],
                 item['password']);
             users.add(user);
           }

           return APIResponse<List<User>>(data: users);
         }
         return APIResponse<List<User>>(errer: true,errorMessage: " An errer 1");
   }).catchError((_) =>  APIResponse<List<User>>(errer: true,errorMessage: " An errer 2"));
  }



  Future<APIResponse<User>> Login(UserParam item){
    //print(item.email+' '+item.password);
    return http.post(API+"auth" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {

      if(data.statusCode == 200){
        final Map<String, dynamic> jsonData = json.decode(data.body);
           var item = jsonData["user"];
        print(item);
       // print(jsonData["hasOrtho"]);
           final user = User(
               item['id'],
               item['name'],
               item['email'],
               item['password'],
               item['type'],
               code :item['code'],
               phone: item['phone'],
               score: item['score'],
               token: jsonData["token"],
               hasOrtho: item["hasOrtho"]);
           return APIResponse<User>(data: user);
      }
      return APIResponse<User>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<User>(errer: true,errorMessage: " An errer 2"));
  }

  Future<APIResponse<User>> SignUp(UserParam item){
    item.score="0";
    item.phone="null";
   // print(json.encode(item.toJson()));
    return http.post(API+"register" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
     // print(data.statusCode.toString() );
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);
        if(jsonData["message"] != null){
          return APIResponse<User>(errer: true,errorMessage: jsonData["message"]);
        }else {
          var item = jsonData["user"];
          final user = User(
              item['id'],
              item['name'],
              item['email'],
              item['type'],
              item['password'],
              phone: item['phone'],
              score: item['score']);
          return APIResponse<User>(data: user);
        }
      }
      return APIResponse<User>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<User>(errer: true,errorMessage: " Opps server Errer"));
  }

  Future<APIResponse<User>> SignUpOrtho(UserParam item){
    print(json.encode(item.toJson()));
    return http.post(API+"registerOrtho" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString() );
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);

        if(jsonData["message"] != null){
          print(jsonData["message"]);
          return APIResponse<User>(errer: true,errorMessage: jsonData["message"]);
        }else {
          var item = jsonData["user"];
          final user = User(
            item['id'],
            item['name'],
            item['email'],
            item['type'],
            item['password'],
            code: item['code'],
              phone: item['phone'],
              score: item['score']);
          return APIResponse<User>(data: user);
        }
      }
      return APIResponse<User>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<User>(errer: true,errorMessage: " Opps server Errer"));
  }

  Future<APIResponse<User>> Update(UserParam item){
    print(json.encode(item.toJson()));
    return http.post(API+"update" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString() );
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);

        if(jsonData["message"] != null){
          print(jsonData["message"]);
          return APIResponse<User>(errer: true,errorMessage: jsonData["message"]);
        }else {
          var item = jsonData["user"];
          final user = User(
              item['id'],
              item['name'],
              item['email'],
              item['type'],
              item['password'],
              code: item['code'],
              phone: item['phone'],
              score: item['score']
              );
          return APIResponse<User>(data: user);
        }
      }
      return APIResponse<User>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<User>(errer: true,errorMessage: " Opps server Errer"));
  }



  Future<APIResponse<User>> hasOrtho(UserParam item){
    print(json.encode(item.toJson()));
    return http.post(BASE_URL+"hasOrth/"+"add" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString() );
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);

        if(jsonData["message"] != null){
          print(jsonData["message"]);
          return APIResponse<User>(errer: true,errorMessage: jsonData["message"]);
        }else {
          var item = jsonData["hasOrth"];
          final user = User(
              item['id'],
              item['name'],
              item['email'],
              item['type'],
              item['password'],
              code: item['code'],
              phone: item['phone'],
              score: item['score']
          );
          return APIResponse<User>(data: user);
        }
      }
      return APIResponse<User>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<User>(errer: true,errorMessage: " Opps server Errer"));
  }

  Future<bool> getHasOrthoByIdP(UserParam   item){
    print(json.encode(item.toJson()));
    return http.post(BASE_URL+"hasOrth/"+"getByIdP" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString() );
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);
        print('jsonData["success"]');
        print(jsonData["success"]);
        if(jsonData["success"] != null){
          print('jsonData["success"]1');
          print(jsonData["success"]);

           if(jsonData["success"].toString() == "true"){
             print('jsonData["success"]2');
             print(jsonData["success"]);
             return true;

           }else{
             print('jsonData["success"]3');
             print(jsonData["success"]);
             return false;
           }

        }else {

          return false;
        }
      }
      return false;
    }).catchError((_) =>  false);
  }




  Future<List<OrthoParam>> gatAllByIdOrtho(UserParam item){
  //  print(json.encode(item.toJson()));
    var parm ={"id" :item.id};
    print(json.encode(parm));
    return http.post(BASE_URL+"hasOrth/"+"getByIdOrtho" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString() );
     // print(data.body);
      List<OrthoParam>  list = <OrthoParam>[];
      if(data.statusCode == 200){

        Map<String, dynamic> jsonData = json.decode(data.body);

       print(jsonData);

        for(var item in jsonData.values.last ){

          print("item");
          print(item);


          OrthoParam orthoParam = OrthoParam(
            valid: item["valid"],
            id: item["_id"],
            idOrtho: item['idOrtho'],
            idP: item["idP"],
            nameP: item["nameP"]
          );

         list.add(orthoParam);
        }


      }
      return list;
    });
  }


  Future<APIResponse<User>> Approuve(OrthoParam item){
    print(json.encode(item.toJson()));
    return http.post(BASE_URL+"hasOrth/"+"update" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString() );
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);

        if(jsonData["success"] != null){
          print(jsonData["message"]);
          return APIResponse<User>(errer: true,errorMessage: jsonData["message"]);
        }else {

          return APIResponse<User>(errer: false);
        }
      }
      return APIResponse<User>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<User>(errer: true,errorMessage: " Opps server Errer"));
  }

  Future<APIResponse<User>> deleteHasOrth(OrthoParam item){
    print(json.encode(item.toJson()));
    return http.post(BASE_URL+"hasOrth/"+"delete" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString() );
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);

        if(jsonData["success"] != null){
          print(jsonData["message"]);
          return APIResponse<User>(errer: true,errorMessage: jsonData["message"]);
        }else {

          return APIResponse<User>(errer: false);
        }
      }
      return APIResponse<User>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<User>(errer: true,errorMessage: " Opps server Errer"));
  }


  Future<APIResponse<OrthoParam>> getPatient(OrthoParam item){
   // print(json.encode(item.toJson()));
    return http.post(BASE_URL+"hasOrth/"+"getPatient" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
     // print(data.statusCode.toString() );
      List<OrthoParam>  list = <OrthoParam>[];
      if(data.statusCode == 200){

        Map<String, dynamic> jsonData = json.decode(data.body);

       // print(jsonData);

        for(var item in jsonData.values.last ){

        //  print("item");
        //  print(item);


          OrthoParam orthoParam = OrthoParam(
              valid: item["valid"],
              id: item["_id"],
              idOrtho: item['idOrtho'],
              idP: item["idP"],
              nameP: item["nameP"]
          );

          list.add(orthoParam);

        }
        return APIResponse<OrthoParam>(data1: list,errer: false);
        }else {

          return APIResponse<OrthoParam>(errer: true);
        }

      return APIResponse<OrthoParam>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<OrthoParam>(errer: true,errorMessage: " Opps server Errer"));
  }

  Future<bool> getAllExercice(){
    return  http.get(BASE_URL+"exercices/list",headers: headers)
        .then((data) {
      print(data.statusCode.toString() );
      if(data.statusCode == 200){
        Map<String, dynamic> jsonData = json.decode(data.body);
        print(jsonData);
        List<Exercice>  list = <Exercice>[];

        for(var item in jsonData.values.last ){
          print("item");
          Exercice exercice = Exercice(
              category: item["category"],
              id: item["_id"],
              type: item['type'],
              score: item["score"],
              name: item["name"],
              niveau :item["niveau"]
          );
          print(exercice.id);
          print(exercice.name);
          print(exercice.type);
          print(exercice.category);
          print(exercice.niveau);
          print(exercice.score);

          list.add(exercice);
        }
        print(list.length);
        return list ;
        print("");
      }else {

        return APIResponse<Exercice>(errer: true);
      }

      return APIResponse<OrthoParam>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<Exercice>(errer: true,errorMessage: " Opps server Errer"));
  }




  Future<APIResponse<ToDoParam>> addToDo(ToDoParam item){
   item.AvgScore ="0";
    print(json.encode(item.toJson()));
    return http.post(BASE_URL+"todo/"+"add" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString() );
      print(data.body);
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);

          var item = jsonData["todo"];
          print(item);
          final todo = ToDoParam(
              id : item['_id'],
              AvgScore:  item['AvgScore'],
              idExercice: item['idExercice'],
              idUser: item['idUser']
          );
          return APIResponse<ToDoParam>(data: todo,errer: false);
      }
      return APIResponse<ToDoParam>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<ToDoParam>(errer: true,errorMessage: " Opps server Errer"));
  }

  Future<APIResponse<List<User>>> getToDoByIdOrtho(){
    //  print("jsonData");
    const uri = API+"list";
    return http.get(uri)
        .then((data) {
      //  print(data);
      if(data.statusCode == 200){
        final Map<String, dynamic> jsonData = json.decode(data.body);
        final users = <User>[];
        pref.addUserToken(jsonData["token"]);
        for(var item in jsonData.values.first ){
          final user = User(
              item['_id'],
              item['name'],
              item['email'],
              item['type'],
              item['password']);
          users.add(user);
        }

        return APIResponse<List<User>>(data: users);
      }
      return APIResponse<List<User>>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<List<User>>(errer: true,errorMessage: " An errer 2"));
  }








}