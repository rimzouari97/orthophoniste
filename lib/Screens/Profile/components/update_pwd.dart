import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/Home/home.dart';
import 'package:orthophoniste/Screens/Login/login_screen.dart';
import 'package:orthophoniste/Screens/Signup/components/background.dart';
import 'package:orthophoniste/Screens/Signup/components/or_divider.dart';
import 'package:orthophoniste/Screens/Signup/components/social_icon.dart';
import 'package:orthophoniste/Screens/Signup/signup_ortho_screen.dart';
import 'package:orthophoniste/backend/backHome.dart';
import 'package:orthophoniste/components/already_have_an_account_acheck.dart';
import 'package:orthophoniste/components/rounded_button.dart';
import 'package:orthophoniste/components/rounded_input_field.dart';
import 'package:orthophoniste/components/rounded_password_field.dart';
import 'package:orthophoniste/constants.dart';
import 'package:orthophoniste/main.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UpdatePwd extends StatefulWidget {

  String _id,_name;
  String _oldPwd,_newPwd1,_newPwd2;
  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();

  @override
  _UpdatePwdState createState() => _UpdatePwdState();
}

class _UpdatePwdState extends State<UpdatePwd> {
  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();

  void initState() {
    super.initState();

  }

  UserService get service => GetIt.I<UserService>();
  bool b = true ;



  Future<bool> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        debugPrint('Step 2, fetch data');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        widget._name = await preferences.getString('UserName');
        widget._id = await preferences.getString('UserId');
        print(widget._id);

        return true;
      });


  @override
  Widget build(BuildContext context) =>
      FutureBuilder(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            Size size = MediaQuery
                .of(context)
                .size;
            print(snapshot.data);
            if(b){
              return Scaffold(
                appBar: AppBar(title: Text("Change Password"),
                ),
                body:Form(
                  key: _keyForm,
                  child: Background(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Text(widget._name + " Change your pls " ),

                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                icon: IconButton(
                                  icon: Icon(Icons.vpn_key_rounded),
                                ),
                                labelText: 'Old password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "must not be empty";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (String value) {
                                widget._oldPwd = value;
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                icon: IconButton(
                                  icon: Icon(Icons.vpn_key_rounded),
                                ),
                                labelText: 'new  password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "must not be empty";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (String value) {
                                widget._newPwd1 = value;
                              },
                            ),TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                icon: IconButton(
                                  icon: Icon(Icons.vpn_key_rounded),
                                ),
                                labelText: 'new  password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "must not be empty";
                                }else if(widget._newPwd1 == value) {
                                  return "password not eqauls";
                                }else {
                                  return null;
                                }
                              },
                              onSaved: (String value) {
                                widget._newPwd2 = value;
                              },
                            ),

                            SizedBox(child: Text(""), height: 25,),
                            RoundedButton(
                                text: "change",
                                press: () async {
                                  if (!_keyForm.currentState.validate())
                                    return;
                                  _keyForm.currentState.save();
                                  UserParam userP = UserParam(id: widget._id,name: widget._name);
                                  //   userP.code = userP.hashCode;
                                  print("userP.id");
                                  print(userP.id);
                                  final result = await service.hasOrtho(userP);

                                  if (!result.errer) {
                                    setState(() {
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {

                                          return AlertDialog(
                                            title: Row(
                                                children: [
                                                  Icon(Icons.info,
                                                      color: Colors.blueAccent),
                                                  Text('  Info. '),

                                                ]
                                            ),
                                            actions: [
                                              FlatButton(
                                                  child: Text('Yes'),
                                                  onPressed: () {
                                                    setState(() {
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],

                                            content: Text(
                                                "Wiating ortho for approve"),




                                          );
                                        }
                                    );
                                  } else if (result.errer) {

                                    final text = result.errorMessage;


                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Info"),
                                          content: Text(text),
                                          actions: [
                                            FlatButton(
                                                child: Text('Yes'),
                                                onPressed: () {
                                                  setState(() {
                                                  });
                                                  Navigator.of(context).pop();
                                                }),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                            ),



                          ],
                        ),
                      ),
                    ),
                  ),
                ) ,

              );
            }else{

              debugPrint('Step 1, build loading widget');
              return Center( child:Column(
                children: [
                  SizedBox(
                    child: CircularProgressIndicator(backgroundColor: Colors.white,semanticsLabel: "Wiating  for approve",),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.all(50 ),
                    child: Text("Wiating  for approve"),
                  ),

                ],
              )
              );
            }
          });
}
