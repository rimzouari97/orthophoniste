import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orthophoniste/shared_preferences.dart';

import 'griddashboard.dart';


class backHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MyHomeBack();
  }
}

class MyHomeBack extends StatefulWidget {
  @override
  _MyHomeBackState createState() => _MyHomeBackState();
}

class _MyHomeBackState extends State<MyHomeBack> {
  final Future<String> _name = Future<String>.delayed(
      const Duration(microseconds: 100),() {
    SharedPref pref = SharedPref();
    return  pref.getUserName();
  }
  );

  @override
  Widget build(BuildContext context) => FutureBuilder(
  future: _name, //fetchData(),
  builder: (context, snapshot) {
  if(snapshot.hasData) {
    return Scaffold(
      backgroundColor: Color(0xff392850),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 110,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      snapshot.data.toString(),
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Home",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: Image.asset(
                    "assets/images/notification.png",
                    width: 24,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GridDashboard()
        ],
      ),
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
  }

  
