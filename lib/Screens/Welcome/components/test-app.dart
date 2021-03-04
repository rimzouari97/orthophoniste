import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:orthophoniste/services/user_service.dart';

class TestApp extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<TestApp> {

  UserService get service => GetIt.I<UserService>();
  APIResponse <List<User>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchUsers();
    super.initState();
  }

  _fetchUsers() async{

    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getUsersList();

    setState(() {
      _isLoading = false;
    });


  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return /*Builder(builder: (_){
      if(_isLoading){
        return CircularProgressIndicator();
      }
      if(_apiResponse?.errer){
        return Center(child: Text(_apiResponse.errorMessage));
      }
    return*/  Card(child: Row(
        children: [

          Container(
            margin: EdgeInsets.fromLTRB(50, 50, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("_apiResponse.data[0].name"),
              //  Text(_apiResponse.data[1].name),
             //   Text(_apiResponse.data[2].name),


              ],
            ),
          )
        ],
      ),
      );
   // });

  }


}