import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/models/exercice.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DropdowenMuneExercice extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<DropdowenMuneExercice> {

  List<Exercice> dropdownItems1 = [
    Exercice(id: "2",name: "text 1")
  ];

  List<DropdownMenuItem<Exercice>> _dropdownMenuItems1;
  Exercice _selectedItem1;
  UserService get service => GetIt.I<UserService>();


  Future<bool> fetchData() => Future.delayed(Duration(microseconds: 5000), () async{
    debugPrint('Step 2, fetch data');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id  = prefs.getString('UserId');
    print(id);

   // return await service.getAllExercice();

    return true;
  });

  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context)  => FutureBuilder(
      future: fetchData(), //fetchData(),
      builder: (context, snapshot) {


        if(snapshot.hasData){

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
          try {
           // dropdownItems1 = snapshot.data;
            _dropdownMenuItems1 = buildDropDownMenuItems1(dropdownItems1);
            _selectedItem1 = _dropdownMenuItems1[0].value;
          }catch(e){
            print(e);
          }

          return  Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Exercice : "),
                        DropdownButton<Exercice>(
                            value: _selectedItem1,
                            items: _dropdownMenuItems1,
                            onChanged: (value) {
                              setState(() {
                                _selectedItem1 = value;
                              });
                            }),
                      ],
                    )
                  ],
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
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}