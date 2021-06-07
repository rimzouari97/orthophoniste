import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _codeUser,_name = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> fetchData() => Future.delayed(Duration(microseconds: 3000), () async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _name = preferences.getString('UserName');
    _codeUser = preferences.getString('UserCode');

    return true;
  });


  @override
  Widget build(BuildContext context) => FutureBuilder(
  future: fetchData(), //fetchData(),
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
                      _name,
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
                  icon: Icon(Icons.vpn_key_rounded,color: Colors.white,),
                  onPressed: () {
                    print(_codeUser);
                    showDialog(
                    context: context,
                    builder: (BuildContext context)
                    {
                      return AlertDialog(
                        title: Row(
                            children: [
                              Icon(Icons.info, color: Colors.blueAccent),
                              Text(' Verification number  . ')
                            ]
                        ),
                        content: Text("Your code is :  " + _codeUser),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, child: Text('ok'),
                            color: Colors.deepPurple,
                          )
                        ],
                      );
                    },
                    );


                  },
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

  
