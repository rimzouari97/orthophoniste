//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/Home/home.dart';
import 'package:orthophoniste/Screens/Home/screens/details_screen.dart';
import 'package:orthophoniste/Screens/Home/widgets/category_card.dart';
import 'package:orthophoniste/Screens/Login/hasOrth.dart';
import 'package:orthophoniste/Screens/Signup/signup_screen.dart';
import 'package:orthophoniste/backend/backHome.dart';
import 'package:orthophoniste/components/already_have_an_account_acheck.dart';
import 'package:orthophoniste/components/rounded_button.dart';
import 'package:orthophoniste/components/rounded_input_field.dart';
import 'package:orthophoniste/components/rounded_password_field.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/user_service.dart';
import 'package:orthophoniste/services/stutter_service.dart';

import 'package:orthophoniste/shared_preferences.dart';

import 'background.dart';

class Body extends StatefulWidget {
  String _email;
  String _pwd;

  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();
  SharedPref pref = SharedPref();
  UserService get service => GetIt.I<UserService>();
  StutterService get stutterservice => GetIt.I<StutterService>();
  APIResponse<User> _apiResponse;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _keyForm,
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: IconButton(
                    icon: Icon(Icons.mail),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "must not be empty";
                  } else {
                    return null;
                  }
                },
                onSaved: (String value) {
                  widget._email = value;
                },
              ),
              SizedBox(child: Text("")),
              Container(
                child: new Column(
                  children: <Widget>[
                    new TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: IconButton(
                          icon: new Icon(Icons.lock),
                          onPressed: _toggle,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "must not be empty";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) => widget._pwd = val,
                      obscureText: _obscureText,
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Text(""),
                height: 50,
              ),
              RoundedButton(
                text: "LOGIN",
                press: () async {
                  if (!_keyForm.currentState.validate()) return;
                  _keyForm.currentState.save();
                  UserParam userP =
                      UserParam(email: widget._email, password: widget._pwd);

                  final result1 =
                      await service.Login(userP).then((result) async {
                    if (result.data != null) {
                      pref.addUserEmail(result.data.email);
                      pref.addUserName(result.data.name);
                      pref.addUserType(result.data.type);
                      pref.addUserId(result.data.id);
                      pref.addUserCode(result.data.code);
                      pref.addUserPhone(result.data.phone);
                      pref.addUserScore(result.data.score);
                      pref.addHasOrtho(result.data.hasOrtho);
                      print("result.data.hasOrtho");
                      print(result.data.hasOrtho);
                      pref.addUserCon();
                      if (result.data.type == "patient") {
                        if (result.data.hasOrtho == "true") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomeScreen(),
                            ),
                            (route) => false,
                          );
                        } else {
                          print('gggggggggggggggggggggg');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => HasOrth(),
                            ),
                            (route) => false,
                          );
                        }
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => backHome(),
                          ),
                          (route) => false,
                        );
                      }
                    }

                    String
                        text; //= result.errer ? (result.errorMessage ?? " An errer 1") : 'you are connected';
                    if (result.errer == true) {
                      text = "Address or password incorrect";
                    } else {
                      print("hi getting stutter progress");
                      await stutterservice.getStutterProgress(result.data.id);
                      text = 'you are connected';
                    }

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Row(children: [
                              Icon(Icons.info, color: Colors.blueAccent),
                              Text(result.errer == true
                                  ? '  Erorr. '
                                  : '  Welcome.  ')
                            ]),
                            content: Text(text));
                      },
                    );
                  });
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
