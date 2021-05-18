import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orthophoniste/data/draggable_animal.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/done.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/done_service.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'griddashboard.dart';


class DoneList extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return MyDoneList();
  }
}

class MyDoneList extends StatefulWidget {
  @override
  _MyDoneListState createState() => _MyDoneListState();
  String _name;
  String _id;

}

class _MyDoneListState extends State<MyDoneList> {

  UserService get service => GetIt.I<UserService> ();
  APIResponse rep;
  Future<List<OrthoParam>> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        widget._name = await preferences.getString('UserName');
        widget._id = await preferences.getString('UserId');

        return  await service.gatAllByIdOrtho(UserParam(id: widget._id));

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
              title: Text("Patient List "),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                  children:[
                                    Icon(Icons.info,color: Colors.blueAccent),
                                    Text('  Info . ')
                                  ]
                              ),
                              content: Text("Exercice "+  " affecter a " ),
                              actions: [
                                MaterialButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text('ok'),
                                  color: Colors.deepPurple,
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                          Icons.info_outline
                      ),
                    )
                ),
              ],
            ),
            body:Container(child: Center(child: Text(" No Patient   "),)),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Patient List "),
            actions: <Widget>[
              Tooltip(
                message: "message",

               child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                                showDialog(
                        context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                  children: [
                                    Icon(Icons.info, color: Colors.blueAccent),
                                    Text('  Info . ')
                                  ]
                              ),
                              content: Text("Exercice " + " affecter a "),
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
        return ListView.builder(
          itemCount: len,
          itemBuilder: (context, index) {
           OrthoParam  item = Snap.data[index];

            if(item.valid == "true"){
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
                direction: DismissDirection.endToStart,
                background: Container(color: Colors.green,
                  child: Icon(Icons.check),
                ),

                secondaryBackground: Container(color: Colors.red,
                  child: Icon(Icons.cancel),
                ),
                onDismissed: (direction){
                    Delete(item);

                },
              );
            }else {
              return Container();
            }

          }
          );

      },
      future: fetchData(),
    );
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