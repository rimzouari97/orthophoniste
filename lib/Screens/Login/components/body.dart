import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/Home/home.dart';
import 'package:orthophoniste/Screens/Home/screens/details_screen.dart';
import 'package:orthophoniste/Screens/Home/widgets/category_card.dart';
import 'package:orthophoniste/Screens/Signup/signup_screen.dart';
import 'package:orthophoniste/components/already_have_an_account_acheck.dart';
import 'package:orthophoniste/components/rounded_button.dart';
import 'package:orthophoniste/components/rounded_input_field.dart';
import 'package:orthophoniste/components/rounded_password_field.dart';
import 'package:orthophoniste/models/API_response.dart';
import 'package:orthophoniste/models/user_info.dart';
import 'package:orthophoniste/models/user_parm.dart';
import 'package:orthophoniste/services/user_service.dart';

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

  UserService get service => GetIt.I<UserService>();
  APIResponse <User> _apiResponse;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Form(
      key: _keyForm,
      child : Background(
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
            /*RoundedPasswordField(
              onChanged: (value) {
                widget.pwd = value;

              },
            ),
             */
            Text(""),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
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
                print(value);
              },
            ),

              RaisedButton(
                 child: Text ("LOGIN"),
                onPressed: () async {
                  if(!_keyForm.currentState.validate())
                    return;
                _keyForm.currentState.save();

                 final result = await service.Login(UserParam( email: widget._email, password: widget._pwd));
                  if (result.data != null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen();
                        },
                      ),
                    );

                  }



                  final text = result.errer ? (result.errorMessage ?? " An errer 1") : 'you are connected';

                 showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text("test"),
                          content: Text(text)
                      );
                    },
                  );


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



