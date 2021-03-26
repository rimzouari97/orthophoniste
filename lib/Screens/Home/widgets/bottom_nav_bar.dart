import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orthophoniste/Screens/Home/constants.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
//this gonna give us total height and with of our device
    return MyBottomNavBar();
  }

}

class MyBottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<MyBottomNavBar> {

  bool _Active= false;
  void _toggle() {
    setState(() {
      _Active2 = false;
      _Active1 = false;
      _Active = true;
    });
  }
  bool _Active1 = false;
  void _toggle1() {
    setState(() {
      _Active2 = false;
      _Active = false;
      _Active1 = true;
    });
  }
  bool _Active2 = false;
  void _toggle2() {
    setState(() {
      _Active = false;
      _Active1 = false;
      _Active2 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    const bool active = false;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Today",
            svgScr: "assets/icons/calendar.svg",
            isActive: _Active,
            press: (){
              _toggle();
            },
          ),
          BottomNavItem(
            title: "All Exercises",
            svgScr: "assets/icons/gym.svg",
            isActive: _Active1,
            press: (){
              _toggle1();
            },
          ),
          BottomNavItem(
            title: "Settings",
            svgScr: "assets/icons/Settings.svg",
            isActive: _Active2,
            press: (){
              _toggle2();
            },
          ),
        ],
      ),
    );
  }

}



class BottomNavItem extends StatelessWidget {
  final String svgScr;
  final String title;
  final Function press;
  final bool isActive;
  const BottomNavItem({
    Key key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            svgScr,
            color: isActive ? kActiveIconColor : kTextColor,
          ),
          Text(
            title,
            style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}


