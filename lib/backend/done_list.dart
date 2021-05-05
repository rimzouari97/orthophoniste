import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
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

  DoneService get service => GetIt.I<DoneService> ();
  APIResponse rep;
  Future<List<Done>> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        widget._id = await preferences.getString('idUser');
        return  await service.getAllByIdDone(Done(id: widget._id));

        // return list;

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
              title: Text("Done lessons"),
            ),
            body:Container(child: Center(child: Text(" No lessons "),)),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Done lessons"),
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
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: [
                      Text(" "),
                      Text(Snap.data[index].exerciceName),
                      Text(Snap.data[index].score),

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





}