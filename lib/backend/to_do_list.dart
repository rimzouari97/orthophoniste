import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/exercice.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/todo_param.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart'as http;
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
  List<OrthoParam> listUser =[];
  List<Exercice> listExe =[];


  void initState() {
    super.initState();

 //   background: Container(color: Colors.red);

  }


  Future<List<ToDoParam>> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        widget._id = await preferences.getString('UserId');
        listUser = await service.gatAllByIdOrtho(UserParam(id: widget._id));
        await http.get(BASE_URL+"exercices/list",headers: headers)
            .then((data) {
          //   print(data.statusCode.toString() );
          if(data.statusCode == 200){
            Map<String, dynamic> jsonData = json.decode(data.body);
            //  print(jsonData);
            // List<Exercice>  list = <Exercice>[];
            listExe.clear();

            for(var item in jsonData.values.last ){
              //  print("item");
              Exercice exercice = Exercice(
                  category: item["category"],
                  id: item["_id"],
                  type: item['type'],
                  score: item["score"],
                  name: item["name"],
                  niveau :item["niveau"]
              );
              // print(exercice.id);
              //print(exercice.name);


              // list.add(exercice);
              listExe.add(exercice);
            }
            //  print(list.length);

          }

        });

      //  print(widget._id);

        var res =  await service.getToDoByIdOrtho(ToDoParam(idOrtho:widget._id));
      //  print(res.length);
         return res;

      });

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: fetchData(), //fetchData(),
    builder: (context, snapshot) {
      if(snapshot.hasData) {
     //   print('eeeeeeeeeeee');
        // print(snapshot.data.length );
        if(snapshot.data.length == 0){
          return Scaffold(
            appBar: AppBar(
              title: Text("List To Do patient"),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        print("ff");
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                    children: [
                                      Icon(Icons.info, color: Colors.blueAccent),
                                      Text(' Patients list ')
                                    ]
                                ),
                                content: Text("Here's the list of all the patients who were approved by their pathologists. If you want to delete a patient, you can swipe right."),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text('ok'),
                                    color: Colors.deepPurple,
                                  )
                                ],
                              );
                            }
                        );
                      },
                      child: Icon(
                          Icons.info_outline

                      ),
                    )
                ),



              ],
            ),
            body:Container(child: Center(child: Text(" pas de patient"),)),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("List To Do patient"),
            backgroundColor: Colors.teal,
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      print("ff");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                  children: [
                                    Icon(Icons.info, color: Colors.teal),
                                    Text(' Patients list ')
                                  ]
                              ),
                              content: Text("Here's the list of all the to do patients who were assign by their pathologists. If you want to delete a to do patient, you can swipe right."),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, child: Text('ok'),
                                  color: Colors.teal,
                                )
                              ],
                            );
                          }
                      );
                    },
                    child: Icon(
                        Icons.info_outline

                    ),
                  )
              ),



            ],
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
        future: fetchData(),
        builder: (context, Snap) {
          if (Snap.connectionState == ConnectionState.none &&
              Snap.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Container();
          }
          int len = 0;
          try {
            len = Snap.data.length;
          } catch (e) {
            print(e.toString());
          }
          return ListView.builder(
            itemCount: len,
            itemBuilder: (context, index) {
              ToDoParam item = Snap.data[index];

              return Dismissible(
                // Each Dismissible must contain a Key. Keys allow Flutter to
                // uniquely identify widgets.
                key: Key(item.idUser),
                child: Column(
                  children: <Widget>[
                Neumorphic(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  style: NeumorphicStyle(
                      color: Colors.grey[300],
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12))),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(children: [
                         // Image.network("https://raw.githubusercontent.com/oussamaMaaroufi/orthoBack/master/166395810_233537285126986_5719499729791420255_o.jpg", height: 60, width: 60,),
                          SvgPicture.asset("assets/icons/User Icon.svg",height: 50,width: 50,),
                         Text("     "),
                        //  Text(Snap.data[index].id),
                          NameUser(item.idUser),
                          Text(" "),
                          NameEx(item.idExercice),
                          Text(" "),
                          Text(" "),
                          // Text("Approuve",style: TextStyle(color: Colors.green),),
                          Text(" "),
                          Text(" "),
                          Text(" "),


                        ],

                        ),
                      ),
                    ),

                    // Widget to display the list of project
                  ],
                ),
                  background: Container(color: Colors.green,
                                        child: Icon(Icons.check),
                  ),

                secondaryBackground: Container(color: Colors.red,
                                     child: Icon(Icons.cancel),
                ),
                direction: DismissDirection.endToStart,

                onDismissed: (direction) async {

                    Snap.data.remove(index);
                     service.deleteToDo(ToDoParam(id: item.id)).then((value) {
                       if(value == true){
                         ScaffoldMessenger.of(context)
                             .showSnackBar(SnackBar(content: Row(
                           children: [
                             //      NameUser(item.idUser),
                             //     Text(" "),
                             //     NameEx(item.idExercice),
                             Text(" Delete")
                           ],
                         )
                         ));
                       }else{
                         ScaffoldMessenger.of(context)
                             .showSnackBar(SnackBar(content: Row(
                           children: [
                             //      NameUser(item.idUser),
                             //     Text(" "),
                             //     NameEx(item.idExercice),
                             Text(" Ops")
                           ],
                         )
                         ));
                       }

                     });




                },


              );
            },
          );
        }
    );
  }

  Widget NameUser(String idUser ){
    for(OrthoParam user in listUser){
      print(idUser);
      if(user.idP == idUser){
        return  Text(user.nameP);
      }
    }

  }

  Widget NameEx (String idEx ){
    for(Exercice ex in listExe){
    //  print(ex.name);
      if(ex.id == idEx){
        return  Text(ex.name);
      }
    }
    return  Text("");

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