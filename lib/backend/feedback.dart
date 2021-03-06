import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/charts/page/home_page.dart';
import 'package:orthophoniste/Screens/charts/page/line_chart_page.dart';
import 'package:orthophoniste/Screens/charts/widget/line_chart_widget.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/exercice.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/todo_param.dart';
import 'package:orthophoniste/services/done_service.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';


class FeedbackWidget extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Feedback();
  }
}



class Feedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {

  List<OrthoParam> _dropdownItems = [
    OrthoParam(id: "1", nameP: "First Value"),
    OrthoParam(id :"2", nameP: "Second Item")
  ];

  List<DropdownMenuItem<OrthoParam>> _dropdownMenuItems;
  OrthoParam _selectedItem ;
  List<Exercice> dropdownItems1 = [
    //   Exercice(id: "2",name: "Exercice 1"),
    //   Exercice(id: "2",name: "Exercice 2"),
    //   Exercice(id: "3",name: "Exercice 3"),
    //  Exercice(id: "4",name: "Exercice 4"),
  ];

  List<DropdownMenuItem<Exercice>> _dropdownMenuItems1;
  Exercice _selectedItem1 ;
  UserService get service => GetIt.I<UserService>();
  DoneService get service1 => GetIt.I<DoneService>();


  Future<List<OrthoParam>> fetchData() => Future.delayed(Duration(microseconds: 5000), () async{
    debugPrint('Step 2, fetch data');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id  = prefs.getString('UserId');
    //print(id);

    http.get(BASE_URL+"exercices/list",headers: headers)
        .then((data) {
      //   print(data.statusCode.toString() );
      if(data.statusCode == 200){
        Map<String, dynamic> jsonData = json.decode(data.body);
        //  print(jsonData);
        // List<Exercice>  list = <Exercice>[];
        dropdownItems1.clear();

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
          dropdownItems1.add(exercice);
        }
        //  print(list.length);

      }

    });

    var res  = await service.getPatient(OrthoParam(idOrtho: id));
    _dropdownItems = res.data1;
    return res.data1;
    //return false;
  });




  @override
  Widget build(BuildContext context)  => FutureBuilder(
      future: fetchData(), //fetchData(),
      builder: (context, snapshot) {


        if(snapshot.hasData){


          try {
            _dropdownItems = snapshot.data;
            _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
            _dropdownMenuItems1 = buildDropDownMenuItems1(dropdownItems1);

          }catch(e){
            print(e);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("Show chart"),
                backgroundColor: Colors.teal,
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
                                      Icon(Icons.info,color: Colors.teal),
                                      Text(' Show statics ')
                                    ]
                                ),
                                content: Text("You can select your patient and the assigned lesson before hitting the show button" ),
                                actions: [
                                  MaterialButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text('ok'),
                                    color: Colors.teal,
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
                ]
            ),
            body: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/hh.png",height: 100,width: 100,),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("Patient       "),
                        DropdownButton(
                          //    value: _selectedItem  ,
                            hint: Text("SELECT PATIENT"),
                            items: _dropdownMenuItems,
                            onChanged: ( value) {
                              //    print("_selectedItem");
                              //    print(value);
                              _selectedItem = value;



                            }),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Assignement   "),
                        DropdownButton<Exercice>(
                          //  value: _selectedItem1  ,
                            hint: Text("SELECT EXERCICE"),
                            items: _dropdownMenuItems1,

                            onChanged: (value) {
                              _selectedItem1 = value;

                            }),
                      ],
                    ),
                    SizedBox(height: 20,),
                    MaterialButton(
                        color: Colors.teal,
                        child: Text("Show"),
                        shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.teal)
                        ),
                        onPressed:() async {
                          print("text");
                          print(_selectedItem.nameP);
                          print(_selectedItem1.name);
                          setState(() {
                            print("_selectedItem.nameP");
                            print(_selectedItem.nameP);
                        ToDoParam   toDoParam = ToDoParam(idExercice: _selectedItem1.id,idUser: _selectedItem.idP);
                        toDoParam.idOrtho = _selectedItem.nameP;
                        toDoParam.id = _selectedItem1.name;
                            print(toDoParam.idUser);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Row(
                                        children:[
                                          Icon(Icons.info,color: Colors.blueAccent),
                                          Text('  STATUS '),

                                        ]

                                    ),
                                    content: Text(" Statics of the "+ _selectedItem1.name  +" was affected to "+_selectedItem.nameP ),
                                  actions: [
                                    FlatButton(onPressed: (){
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => LineChartWidget(toDoParam),
                                        ),

                                      );
                                    }, child: Text('ok'))
                                  ],
                                );
                              },
                            );


                           // LineChartWidget(toDoParam),
                          });

                        },

                    ),
                   // Text(toDoParam.idUser),


                  ],
                )
            ),


          );

        }else{
          return Center(
            child:

            SizedBox(
              child: CircularProgressIndicator(backgroundColor:  Colors.white,),
              width: 60,
              height: 60,
            ),

          );
        }

      }
  );

  List<DropdownMenuItem<OrthoParam>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<OrthoParam>> items = List();
    for (OrthoParam listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.nameP),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Exercice>> buildDropDownMenuItems1(List listItems1) {
    List<DropdownMenuItem<Exercice>> items = List();
    for (Exercice listItem1 in listItems1) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem1.name),
          value: listItem1,
        ),
      );
    }
    return items;
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}