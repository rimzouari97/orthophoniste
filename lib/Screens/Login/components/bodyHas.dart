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


class BodyHas extends StatefulWidget {

  String _code;
  String _name,_id;
  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<BodyHas> {
  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();

  UserService get service => GetIt.I<UserService>();
  APIResponse <User> _apiResponse;
  bool _obscureText = true;
  SharedPref _prefs = SharedPref();
  SharedPref pref = SharedPref();
  bool b ;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<bool> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        debugPrint('Step 2, fetch data');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        widget._name = await preferences.getString('UserName');
        widget._id = await preferences.getString('UserId');
        final b1 = await service.getHasOrthoByIdP(UserParam(id: widget._id));
        b = b1.errer;
        print("b");
        print(b);
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
            if(!b){

              return Form(
                key: _keyForm,
                child: Background(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Text(" Welcome " + widget._name),

                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              icon: IconButton(
                                icon: Icon(Icons.vpn_key_rounded),
                              ),
                              labelText: 'Code Ortho',
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
                              widget._code = value;
                            },
                          ),

                          SizedBox(child: Text(""), height: 25,),
                          RoundedButton(
                              text: "Save",
                              press: () async {
                                if (!_keyForm.currentState.validate())
                                  return;
                                _keyForm.currentState.save();
                                UserParam userP = UserParam(id: widget._id,code: widget._code,name: widget._name);
                                //   userP.code = userP.hashCode;
                                print("userP.id");
                                print(userP.id);
                                final result = await service.hasOrtho(userP);

                                if (!result.errer) {

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                              children: [
                                                Icon(Icons.info,
                                                    color: Colors.blueAccent),
                                                Text('  Info. ')
                                              ]
                                          ),
                                          content: Text(
                                              "Wiating ortho for approve"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("YES"),
                                              onPressed: () {
                                                //Put your code here which you want to execute on Yes button click.
                                                Navigator.of(context).pop();
                                                print('ok');


                                              },
                                            ),


                                          ],
                                        );
                                      }
                                  );
                                  setState(() {

                                  });
                                } else if (result.errer) {

                                  final text = result.errorMessage;


                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Text("Info"),
                                          content: Text(text)
                                      );
                                    },
                                  );
                                }
                              }
                          ),
                          RoundedButton(
                            text: "logout",
                            press: () async {
                              _prefs.removeValues();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyApp()
                                  ),
                                      (router) => false
                              );
                              print("oooooooooookkkkkkkkkkkkkkkkk");
                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
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
                  RoundedButton(
                    text: "logout",
                    press: () async {
                      _prefs.removeValues();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()
                          ),
                              (router) => false
                      );
                      print("oooooooooookkkkkkkkkkkkkkkkk");
                    },
                  )
                ],
              )
              );
            }
          });
}

/*
 {
              _prefs.removeValues();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyApp()
                ),
                  (router) => false
              );
              print("oooooooooookkkkkkkkkkkkkkkkk");
            },
 */
