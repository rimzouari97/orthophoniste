import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/ProfileOrtho/profile_screen.dart';
import 'package:orthophoniste/models/ortho_parm.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}


class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  UserService get service => GetIt.I<UserService>();
  final FocusNode myFocusNode = FocusNode();
  String _name;
  String _email;
  String _phone = "",_score;
  String _idUser;
  String _newname,_newEmail;
  String  newPhone;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> fetchData() => Future.delayed(Duration(microseconds: 3000), () async {
    debugPrint('Step 2, fetch data');
    SharedPreferences preferences = await SharedPreferences.getInstance();
     _name = preferences.getString('UserName');
     _email = preferences.getString("UserEmail");
     _idUser = preferences.getString('UserId');
     _phone = preferences.getString("UserPhone");
     _score = preferences.getString("UserScore");

    return  true;
  });



  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: fetchData(),
    builder:  (BuildContext context, AsyncSnapshot<bool> snapshot) {
      if(snapshot.hasData) {
            return
              Scaffold(
                appBar: AppBar(
                  title: Text(_name),
                ),
                  body: new Container(
                    color: Colors.white,
                    child: new ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            new Container(
                              height: 250.0,
                              color: Colors.white,
                              child: new Column(
                                children: <Widget>[

                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: new Stack(fit: StackFit.loose, children: <Widget>[
                                      new Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Container(
                                              width: 140.0,
                                              height: 140.0,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                  image: new ExactAssetImage(
                                                      'assets/fox.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                          child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new CircleAvatar(
                                                backgroundColor: Colors.red,
                                                radius: 25.0,
                                                child: new Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          )),
                                    ]),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              color: Color(0xffFFFFFF),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 25.0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Parsonal Information',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            new Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                _status ? _getEditIcon() : new Container(),
                                              ],
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  "User Name",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextField(
                                                decoration:  InputDecoration(
                                                  hintText:  _name,
                                                ),
                                                enabled: !_status,
                                                autofocus: !_status,
                                                onChanged: (val){
                                                  _newname = val;
                                                },

                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                   "Email",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextField(
                                                decoration:  InputDecoration(
                                                    hintText: _email),
                                                enabled: false,
                                                onChanged: (val){
                                                  _newEmail = val;
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Mobile',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextField(
                                                decoration:  InputDecoration(
                                                    hintText: _phone),
                                                onChanged: (val){
                                                  newPhone = val;
                                                },
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),


                                    !_status ? _getActionButtons() : new Container(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
              );


      }else {
        // We can show the loading view until the data comes back.
        debugPrint('Step 1, build loading widget');
        return Center( child:

        SizedBox(
          child: CircularProgressIndicator(backgroundColor: Colors.white,),
          width: 60,
          height: 60,
        ),
          // Padding(
          //   padding: EdgeInsets.all(50 ),
          //  child: Text('Awaiting result...'),
          //   )

        );
      }
    },
  );

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  print(_newname);
                  String name1= _name;
                  if(_newname != null){
                    name1 = _newname;
                  }
                  String phone= _phone;
                  if(newPhone != null){
                    phone = newPhone;
                  }

                  
                  service.Update(UserParam(id: _idUser,name: name1,email: _email,phone: phone)).then((result) {

                    service.UpdateHasOrho(OrthoParam(nameP: name1,idP: _idUser)).then((value)  {

                    SharedPref pref = SharedPref();
                        pref.addUserName(result.data.name);
                    pref.addUserPhone(result.data.phone);
                    print(result.data.name);

                    setState(() {});
                    });


                  });
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });



                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}



//--------------
