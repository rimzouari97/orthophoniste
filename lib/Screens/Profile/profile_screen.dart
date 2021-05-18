import 'package:flutter/material.dart';
import 'package:orthophoniste/Screens/Home/widgets/bottom_nav_bar.dart';
import 'package:orthophoniste/Screens/Profile/components/coustom_bottom_nav_bar.dart';
import 'package:orthophoniste/Screens/Profile/components/enums.dart';


import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      bottomNavigationBar: BottomNavBar( ),
      body: Body(),
   //   bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
