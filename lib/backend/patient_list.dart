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
  Future<APIResponse<OrthoParam>> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        widget._name = await preferences.getString('UserName');
        widget._id = await preferences.getString('UserId');

    return  await service.gatAllByIdOrtho(UserParam(id: widget._id));

   // return list;

  });

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: fetchData(), //fetchData(),
    builder: (context, snapshot) {
      if(snapshot.hasData) {
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
        return ListView.builder(
          itemCount: Snap.data.data1.length,
          itemBuilder: (context, index) {
            try {
              rep = Snap.data as APIResponse;
            }catch( e){

            }
            /*
                    Text(rep.data1[index].nameP),
                    Text(rep.data1[index].valid),

                     */
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
                        Text(rep.data1[index].nameP),
                        Text(" "),
                        Text(" "),
                     // Text("Approuve",style: TextStyle(color: Colors.green),),
                        Text(" "),Text(" "),Text(" "),

                         MaterialButton(
                            padding: EdgeInsets.only(right: 0.0),
                            onPressed:  rep.data1[index].valid == "false"
                                ? () => Approuve(rep, index)
                                : null,

                            child: Text( rep.data1[index].valid == "false"
                                    ? "Approuve"
                                    : "patient", style: TextStyle(
                              color: Colors.green
                          )
                          ),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(side: BorderSide(
                              color: Colors.blue,
                              width: 1,
                              style: BorderStyle.solid
                          ), borderRadius: BorderRadius.circular(50)),
                        ),
                        Text(" "),
                        MaterialButton(

                          padding: EdgeInsets.only(right: 0.0),
                          onPressed: (){
                            print("Supprime");
                            print(rep.data1[index].nameP);
                            Delete(rep, index);
                          },
                          child: Text('supprime', style: TextStyle(
                              color: Colors.green
                          )
                          ),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(side: BorderSide(
                              color: Colors.blue,
                              width: 1,
                              style: BorderStyle.solid
                          ), borderRadius: BorderRadius.circular(50)),
                        ),


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

  dynamic Approuve(APIResponse<OrthoParam> rep,int index) async {
     print(rep.data1[index].id);

      await service.Approuve(OrthoParam(id:rep.data1[index].id,idP:rep.data1[index].idP, )).then((res) => {
        if(!res.errer){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget))

        }else{


        }
      });

  }
  dynamic Delete(APIResponse<OrthoParam> rep,int index) async {
    print(rep.data1[index].id);

    await service.deleteHasOrth(OrthoParam(id:rep.data1[index].id ,idP: rep.data1[index].idP)).then((res) => {
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