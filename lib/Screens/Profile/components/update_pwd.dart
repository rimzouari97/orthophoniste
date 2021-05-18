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
  String _email;
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
        widget._email = await preferences.getString("UserEmail");
        print("widget._email");
        print(widget._email);
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

                          //  Text(widget._name + " Change your password " ),
                            Text(" "),

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
                            Text(" "),
                            Text(" "),
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

                            ),
                            Text(" "),
                            Text(" "),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                icon: IconButton(
                                  icon: Icon(Icons.vpn_key_rounded),
                                ),
                                labelText: 'Confirm  password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),),
                              ),
                              validator: (String value) {
                                print(value);

                                if (value.isEmpty) {
                                  return "must not be empty";

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
                                  if (!_keyForm.currentState.validate()) {
                                    return;
                                  }
                                  _keyForm.currentState.save();
                                  if(widget._newPwd2 != widget._newPwd1){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext
                                      context) {
                                        return AlertDialog(
                                          title: Row(
                                              children: [
                                                Icon(Icons.error,
                                                    color: Colors
                                                        .blueAccent),
                                                Text('  error . ')
                                              ]
                                          ),
                                          content: Text(
                                              "new Password and Confirm  password NOT equals"),
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

                                  } else {
                                    UserParam userP = UserParam(id: widget._id,
                                        name: widget._newPwd1,
                                        password: widget._oldPwd,
                                        email: widget._email);
                                    //   userP.code = userP.hashCode;
                                    print("userP.id");
                                    print(userP.id);
                                    service.UpdatePasssword(userP).then((
                                        value) =>
                                    {
                                      if(value.errer == false){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext
                                          context) {
                                            return AlertDialog(
                                              title: Row(
                                                  children: [
                                                    Icon(Icons.info,
                                                        color: Colors
                                                            .blueAccent),
                                                    Text('  Info . ')
                                                  ]
                                              ),
                                              content: Text(
                                                  "Password changed successfully"),
                                              actions: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    _keyForm.currentState.reset();
                                                    Navigator.pop(context);
                                                  }, child: Text('ok'),
                                                  color: Colors.deepPurple,
                                                )
                                              ],
                                            );
                                          },
                                        )
                                      } else
                                        {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext
                                            context) {
                                              return AlertDialog(
                                                title: Row(
                                                    children: [
                                                      Icon(Icons.info,
                                                          color: Colors
                                                              .blueAccent),
                                                      Text('  Info . ')
                                                    ]
                                                ),
                                                content: Text(
                                                    value.errorMessage),
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
                                          )
                                        }
                                    });
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
