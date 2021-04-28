
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orthophoniste/Screens/ProfileOrtho/profile_screen.dart';
import 'package:orthophoniste/backend/affect_exerecice.dart';
import 'package:orthophoniste/backend/done_list.dart';
import 'package:orthophoniste/backend/patient_list.dart';
import 'package:orthophoniste/backend/to_do_list.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Affect Exercices",
      subtitle: "March, Wednesday",
      event: "",
      Navigator: AffectExercice(),
      img: "assets/images/calendar.png",);

  Items item2 = new Items(
    title: "Patients",
    subtitle: "FROM 1 TO 10",
    event: "",
    img: "assets/images/score1.png",
    Navigator: PatientList()
  );
  Items item3 = new Items(
    title: "Affect Exercices",
    subtitle: "Lucy Mao going to Office",
    event: "",
    img: "assets/images/map.png",

  );
  Items item4 = new Items(
    title: "Activities",
    subtitle: "Rose favirited your Post",
    event: "",
    img: "assets/images/festival.png",
    Navigator: DoneList()
  );
  Items item5 = new Items(
    title: "To do",
    subtitle: "Homework, Design",
    event: "",
    img: "assets/images/todo.png",
   Navigator: ToDoList(),
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    img: "assets/images/setting.png",
    Navigator: ProfileScreenOrtho(),
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return InkWell(
              onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return data.Navigator;
                  }),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color), borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),


                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Widget Navigator;

  Items({this.title, this.subtitle, this.event, this.img,this.Navigator});
}
