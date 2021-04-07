import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/API_response.dart';
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
           final user = User(
               item['id'],
               item['name'],
               item['email'],
               item['password'],
               item['type'],
               code :item['code'],
               phone: item['phone'],
               score: item['score'],
               token: jsonData["token"]);
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



}