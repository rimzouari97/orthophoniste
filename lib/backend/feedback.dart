import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/charts/page/home_page.dart';
import 'package:orthophoniste/Screens/charts/page/line_chart_page.dart';
import 'package:orthophoniste/Screens/charts/widget/line_chart_widget.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/models/exercice.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/todo_param.dart';
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
            //  _selectedItem1 = f
          }catch(e){
            print(e);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("Affectation des Exercice"),
            ),
            body: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Patient  : "),
                        DropdownButton(
                          //    value: _selectedItem  ,
                            hint: Text("select Patient"),
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
                        Text("Exercice : "),
                        DropdownButton<Exercice>(
                          //  value: _selectedItem1  ,
                            hint: Text("select Exercice"),
                            items: _dropdownMenuItems1,

                            onChanged: (value) {
                              //   print("value.name");
                              //   print(value.name);
                              _selectedItem1 = value;

                            }),
                      ],
                    ),

                    FlatButton(
                        onPressed:() async {
                          print("text");
                          print(_selectedItem.nameP);
                          print(_selectedItem1.name);
                          await service.addToDo(ToDoParam(idUser:_selectedItem.idP ,idExercice: _selectedItem1.id)).then((res)  {
                            // print(res.data.id);
                            if(!res.errer){
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
                                      content: Text("Exercice affecter")
                                  );
                                },
                              );
                            }
                          });

                        },
                        child:Container(
                          decoration: BoxDecoration(
                              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                          child:  MaterialButton(child: Text("Save"),color: Colors.deepPurple,),
                        )
                    ),
                    Text(""),
                    Container(
                      width: 600,
                      height: 500,
                      child:  LineChartWidget(),
                    )

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