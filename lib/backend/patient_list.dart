import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'griddashboard.dart';


class PatientList extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return MyPatientList();
  }
}

class MyPatientList extends StatefulWidget {
  @override
  _MyPatientListState createState() => _MyPatientListState();
  String _name;
  String _id;


}

class _MyPatientListState extends State<MyPatientList> {
  UserService get service => GetIt.I<UserService>();
  APIResponse rep;

  void initState() {
    super.initState();

  }


  Future<List<OrthoParam>> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        widget._name = await preferences.getString('UserName');
        widget._id = await preferences.getString('UserId');

    var list =  await service.gatAllByIdOrtho(UserParam(id: widget._id));

    return list;

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
               title: Text("Approuve List "),
               actions: <Widget>[
                 Padding(
                     padding: EdgeInsets.only(right: 20.0),
                     child: GestureDetector(
                       onTap: () {
                         print("lllllllllllllllllllllllllll");
                       },
                       child: Icon(
                           Icons.info_outline
                       ),
                     )
                 ),
               ],
             ),
             body:Container(child: Center(child: Text(" Not patient"),)),
           );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(" Approuve List "),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      print("test pppppppppppp");
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
        return Container(
          child:


            ListView.builder(
            itemCount: len,
            itemBuilder: (context, index) {
              OrthoParam item = Snap.data[index];
              print("item.valid");
              print(item.valid);

              if(item.valid == "false"){
                return Dismissible(
                  key: Key(Snap.data[index].id),
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(children: [
                            Image.network(
                              "https://raw.githubusercontent.com/oussamaMaaroufi/orthoBack/master/166395810_233537285126986_5719499729791420255_o.jpg",
                              height: 60,
                              width: 60,),
                            Text(" "),
                            Text(Snap.data[index].nameP),
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
                  ),

                  background: Container(color: Colors.green,
                    child: Icon(Icons.check),
                  ),

                  secondaryBackground: Container(color: Colors.red,
                    child: Icon(Icons.cancel),
                  ),
                  onDismissed: (direction){
                    if(direction == DismissDirection.startToEnd){
                      Approuve(item);

                    }else{
                      Delete(item);
                    }


                  },
                );
              }else {
                return Container();
              }


            }
        )

        );
      },
      future: fetchData(),
    );
  }

  dynamic Approuve(OrthoParam item) async {


      await service.Approuve(OrthoParam(id:item.id,idP:item.idP, )).then((res) => {
        if(!res.errer){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget))

        }else{


        }
      });

  }
  dynamic Delete(OrthoParam item) async {
    await service.deleteHasOrth(OrthoParam(id:item.id ,idP: item.idP)).then((res) => {
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