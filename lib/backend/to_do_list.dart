import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/todo_param.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'griddashboard.dart';


class ToDoList extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return MyToDoList();
  }
}

class MyToDoList extends StatefulWidget {
  @override
  _MyToDoListState createState() => _MyToDoListState();
  String _id;


}

class _MyToDoListState extends State<MyToDoList> {
  UserService get service => GetIt.I<UserService>();
  APIResponse rep;

  void initState() {
    super.initState();

  }


  Future<List<ToDoParam>> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        widget._id = await preferences.getString('UserId');
        print(widget._id);

        var res =  await service.getToDoByIdUser(ToDoParam(idUser:"60726eb547828200150a7571"));
        print(res.length);
         return res;

      });

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: fetchData(), //fetchData(),
    builder: (context, snapshot) {
      if(snapshot.hasData) {
        print('eeeeeeeeeeee');
        // print(snapshot.data.length );
        if(snapshot.data.length == 0){
          return Scaffold(
            appBar: AppBar(
              title: Text("List Patient"),
            ),
            body:Container(child: Center(child: Text(" pas de patient"),)),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("List Patient"),
          ),
         body: ListWidget(),
        );
      }else {
        debugPrint('Step 3, build loading widget');
        // return CircularProgressIndicator();
        return Center(
          child:
          SizedBox(
            child: CircularProgressIndicator(backgroundColor:  Colors.white,),
            width: 60,
            height: 60,
          ),

        );
      }
    },
  );

  Widget ListWidget() {
    return FutureBuilder(
      builder: (context, Snap) {
        if (Snap.connectionState == ConnectionState.none &&
            Snap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        int len = 0;
        try {
          len = Snap.data.length;
        }catch(e){
          print(e.toString());
        }
        return ListView.builder(
          itemCount: len,
          itemBuilder: (context, index) {

            return Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(children: [
                      Image.network("https://scontent.ftun12-1.fna.fbcdn.net/v/t1.6435-9/48405342_1823459577765035_1096277873884397568_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=24WMN-QgMioAX-NzwGI&_nc_ht=scontent.ftun12-1.fna&oh=10f7bf58608579869ca8b83704157ea3&oe=609BD258",
                        height: 60,
                        width: 60,),
                      Text(" "),
                      Text(Snap.data[index].id),
                      Text(" "),
                      Text(" "),
                      // Text("Approuve",style: TextStyle(color: Colors.green),),
                      Text(" "),Text(" "),Text(" "),


                    ],

                    ),
                  ),
                ),

                // Widget to display the list of project
              ],
            );
          },
        );
      },
      future: fetchData(),
    );
  }


  dynamic Delete(List<OrthoParam> rep,int index) async {
    print(rep[index].id);

    await service.deleteHasOrth(OrthoParam(id:rep[index].id ,idP: rep[index].idP)).then((res) => {
      if(!res.errer){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => super.widget))

      }else{


      }
    });

  }

}