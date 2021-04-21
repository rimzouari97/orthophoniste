import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/backend/dropdowe_mune_exercice.dart';
import 'package:orthophoniste/models/exercice.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/todo_param.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AffectExercice extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AffectExercice> {

  List<OrthoParam> _dropdownItems = [
    OrthoParam(id: "1", nameP: "First Value"),
    OrthoParam(id :"2", nameP: "Second Item")
  ];

  List<DropdownMenuItem<OrthoParam>> _dropdownMenuItems;
  OrthoParam _selectedItem;
  List<Exercice> dropdownItems1 = [
    Exercice(id: "2",name: "Exercice 1"),
    Exercice(id: "2",name: "Exercice 2"),
    Exercice(id: "3",name: "Exercice 3"),
    Exercice(id: "4",name: "Exercice 4"),
  ];
  void initState() {
    super.initState();
   // _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
   // _selectedItem = _dropdownMenuItems[0].value;
    //_selectedItem1 = _dropdownMenuItems1[0].value;


  }

  List<DropdownMenuItem<Exercice>> _dropdownMenuItems1;
  Exercice _selectedItem1;
  UserService get service => GetIt.I<UserService>();


  Future<List<OrthoParam>> fetchData() => Future.delayed(Duration(microseconds: 5000), () async{
    debugPrint('Step 2, fetch data');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id  = prefs.getString('UserId');
    print(id);

    var res  = await service.getPatient(OrthoParam(idOrtho: id));
    return res.data1;
    //return false;
  });




  @override
  Widget build(BuildContext context)  => FutureBuilder(
  future: fetchData(), //fetchData(),
  builder: (context, snapshot) {

    if(snapshot.hasData){


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
      try {
        _dropdownItems = snapshot.data;
        _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
        _selectedItem = _dropdownMenuItems[0].value;
        _dropdownMenuItems1 = buildDropDownMenuItems1(dropdownItems1);
        _selectedItem1 = _dropdownMenuItems1[0].value;

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
                    DropdownButton<OrthoParam>(
                        value: _selectedItem,
                        items: _dropdownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            print(value);
                            _selectedItem = value;
                          });
                        }),
                  ],
                ),
                Row(
                  children: [
                    Text("Exercice : "),
                    DropdownButton<Exercice>(
                        value: _selectedItem1,
                        items: _dropdownMenuItems1,
                        onChanged: (value) {
                     //     setState(() {
                            print(value.name);
                            _selectedItem1 = value;
                        //  });
                        }),
                  ],
                ),

                FlatButton(
                    onPressed:() async {
                      print("text");
                     var res = await service.addToDo(ToDoParam(idUser:_selectedItem.idP ,idExercice: _selectedItem1.id));
                     if(res.errer == false){
                       setState(() {
                         _selectedItem = _dropdownItems.first;
                       });
                     }
                    },
                    child:Container(
                      decoration: BoxDecoration(
                          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                      child:  MaterialButton(child: Text("Save"),color: Colors.deepPurple,),
                    )
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
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}