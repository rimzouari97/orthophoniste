import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/Home/home.dart';
import 'package:orthophoniste/Screens/Login/login_screen.dart';
import 'package:orthophoniste/Screens/Signup/components/background.dart';
import 'package:orthophoniste/Screens/Signup/components/or_divider.dart';
import 'package:orthophoniste/Screens/Signup/components/social_icon.dart';
import 'package:orthophoniste/components/already_have_an_account_acheck.dart';
import 'package:orthophoniste/components/rounded_button.dart';
import 'package:orthophoniste/components/rounded_input_field.dart';
import 'package:orthophoniste/components/rounded_password_field.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/user_service.dart';


class Body extends StatefulWidget {

  String _email;
  String _pwd;
  String _name;
  String _type;
  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();
  UserService get service => GetIt.I<UserService>();
  APIResponse <User> _apiResponse;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Form(
      key: _keyForm,
        child : Background(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Text(
                 "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
                 SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.20,
              ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon:   IconButton(
                        icon:  Icon(Icons.accessibility_new),
                      ),
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          width: 2,
                        ),),
                    ),
                    validator: (String value) {
                      if(value.isEmpty){
                        return "must not be empty";
                      }else{
                        return null;
                      }
                    },
                    onSaved: (String value) {
                      widget._name = value;
                    },
                  ),
                  Text(""),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon:   IconButton(
                        icon:  Icon(Icons.mail),
                      ),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          width: 2,
                        ),),
                    ),
                    validator: (String value) {
                      if(value.isEmpty){
                        return "must not be empty";
                      }else{
                        return null;
                      }
                    },
                    onSaved: (String value) {
                      widget._email = value;
                    },
                  ),
                  Text(""),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      icon:   IconButton(
                        icon:  Icon(Icons.lock),
                        onPressed: _toggle,
                      ),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          width: 2,
                        ),),
                    ),
                    validator: (String value) {
                      if(value.isEmpty){
                        return "must not be empty";
                      }else{
                        return null;
                      }
                    },
                    onSaved: (String value) {
                      widget._pwd = value;
                    },
                    obscureText: _obscureText,
                  ),
                  Text(""),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon:  IconButton(
                         icon: new Icon(Icons.merge_type_rounded),

                  ),
                      labelText: 'Type',
                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (String value) {
                      if(value.isEmpty){
                        return "must not be empty";
                      }else{
                        return null;
                      }
                    },
                    onSaved: (String value) {
                      widget._type = value;
                    },
                  ),
                  SizedBox(child: Text(""),height: 25,),
                  RoundedButton(
                text: "SIGNUP",
                press: () async {
                  if(!_keyForm.currentState.validate())
                    return;
                  _keyForm.currentState.save();
                  final result = await service.SignUp(UserParam(name: widget._name, email: widget._email, password: widget._pwd, type: widget._type));
                     if (result.data != null){
                       Navigator.pushAndRemoveUntil(
                         context,
                         MaterialPageRoute(
                           builder: (BuildContext context) => HomeScreen(),
                         ),
                             (route) => false,
                       );
                     }else{
                  final text =result.errorMessage;



                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text("test"),
                          content: Text(text)
                      );
                    },
                  );
                }


                },
              ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
                 OrDivider(),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                     SocalIcon(
                       iconSrc: "assets/icons/facebook.svg",
                       press: () {},
                  ),
                     SocalIcon(
                       iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                  ),
                     SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                    ),
                  ],
                )
              ],
           ),
            ),
         ),
        ),
    );
  }
}

