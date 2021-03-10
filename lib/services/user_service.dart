import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:http/http.dart'as http;
import 'package:orthophoniste/models/user_parm.dart';
class UserService {

  static  const API = BASE_URL+"users/";


 Future<APIResponse<List<User>>> getUsersList(){
      print("jsonData");
      const uri = API+"list";
   return http.get(uri)
       .then((data) {
     print(data);
         if(data.statusCode == 200){
           final Map<String, dynamic> jsonData = json.decode(data.body);
           final users = <User>[];
           print("jsonData");
           print(jsonData);

          for(var item in jsonData.values.first ){
            print(item);

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
    print(item.email+' '+item.password);
    return http.post(API+"auth" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
          print(data.statusCode.toString() );
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);
         print(jsonData);

          var item = jsonData["user"] ;
          print(item);

          final   user = User(
              item['id'],
              item['name'],
              item['email'],
              item['type'],
              item['password']);

        print(user.name);

        return APIResponse<User>(data: user);
      }
      return APIResponse<User>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<User>(errer: true,errorMessage: " An errer 2"));
  }

  Future<APIResponse<User>> SignUp(UserParam item){
    print(json.encode(item.toJson()));
    return http.post(API+"register" ,headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      print(data.statusCode.toString() );
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);
        print(jsonData);

        var item = jsonData["user"] ;
        print(item);

        final   user = User(
            item['id'],
            item['name'],
            item['email'],
            item['type'],
            item['password']);

        print(user.name);

        return APIResponse<User>(data: user);
      }
      return APIResponse<User>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<User>(errer: true,errorMessage: " An errer 2"));
  }



}