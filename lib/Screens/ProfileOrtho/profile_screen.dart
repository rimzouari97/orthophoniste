import 'package:flutter/material.dart';
import 'package:orthophoniste/Screens/Home/widgets/bottom_nav_bar.dart';
import 'package:orthophoniste/Screens/ProfileOrtho//components/coustom_bottom_nav_bar.dart';
import 'package:orthophoniste/Screens/ProfileOrtho//components/enums.dart';


import 'components/body.dart';

class ProfileScreenOrtho extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BodyOrtho(),
   //   bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
