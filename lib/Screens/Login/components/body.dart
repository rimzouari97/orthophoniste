import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orthophoniste/Screens/Home/home.dart';
import 'package:orthophoniste/Screens/Home/screens/details_screen.dart';
import 'package:orthophoniste/Screens/Home/widgets/category_card.dart';
import 'package:orthophoniste/Screens/Signup/signup_screen.dart';
import 'package:orthophoniste/components/already_have_an_account_acheck.dart';
import 'package:orthophoniste/components/rounded_button.dart';
import 'package:orthophoniste/components/rounded_input_field.dart';
import 'package:orthophoniste/components/rounded_password_field.dart';

import 'background.dart';

class Body extends StatefulWidget {
  /*
  const Body({
    Key key,
  }) : super(key: key);
*/
  String email,pwd;
  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();

  @override
  _BodyState createState() => _BodyState();

}

class _BodyState extends State<Body> {
  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Background(
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (String value) {
                if(value.isEmpty){
                  return "must not be empty";
                }else{
                  return null;
                }
              },
              onSaved: (String value) {
                int.parse(widget.email = value);
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (String value) {
                if(value.isEmpty){
                  return "must not be empty";
                }else{
                  return null;
                }
              },
              onSaved: (String value) {
                int.parse(widget.pwd = value);
              },
            ),
           RaisedButton(
               child: Text ("LOGIN"),
                onPressed: () {
               // _keyForm.currentState.save();
              //  _keyForm.currentState.validate();

                  print("ddddddddddddddddd");

                Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }),);
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
    );
  }

}



