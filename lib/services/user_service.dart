import 'dart:convert';

import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:http/http.dart'as http;
import 'package:orthophoniste/models/user_parm.dart';
class UserService {

  static  const API = "http://rivalsbackend.herokuapp.com/users/";

 Future<APIResponse<List<User>>> getUsersList(){

   return http.get(API +"list")
       .then((data) {
         if(data.statusCode == 200){
           final Map<String, dynamic> jsonData = json.decode(data.body);
           final users = <User>[];
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
    return http.post(API +"auth",body: json.encode(item.toJson()))
        .then((data) {
      if(data.statusCode == 200){

        final Map<String, dynamic> jsonData = json.decode(data.body);
         print(jsonData);

          var item = jsonData.values.first ;
          print(item);

          final   user = User(
              item['_id'],
              item['name'],
              item['email'],
              item['type'],
              item['password']);

        return APIResponse<User>(data: user);
      }
      return APIResponse<User>(errer: true,errorMessage: " An errer 1");
    }).catchError((_) =>  APIResponse<User>(errer: true,errorMessage: " An errer 2"));
  }



}