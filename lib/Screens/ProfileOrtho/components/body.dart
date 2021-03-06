import 'package:flutter/material.dart';
import 'package:orthophoniste/Screens/Profile/components/update_pwd.dart';
import 'package:orthophoniste/Screens/ProfileOrtho/ProfilePage.dart';
import 'package:orthophoniste/main.dart';
import 'package:orthophoniste/shared_preferences.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class BodyOrtho extends StatelessWidget {
  SharedPref _prefs = SharedPref();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
            Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) {
            return ProfilePageOrtho();
            },
            ),
            ),
            },
          ),
          ProfileMenu(
            text: "Change Password",
            icon: "assets/icons/Settings1.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UpdatePwd();
                  },
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
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
    );
  }
}
