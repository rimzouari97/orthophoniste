import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orthophoniste/Screens/Home/level4/widget/exercice.dart';
import 'package:orthophoniste/Screens/Home/level4/widget/speech_to_text.dart';
import 'package:orthophoniste/Screens/Home/level4/widget/text_to_speech.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {

  int _currentTab = 0;

  void _onTapNavBar(int index){
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     final _listPage = <Widget>[
      SpeechToText(),
       Exercice()
     // TextToSpeech()
    ];

    final _navBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.microphone,
          size: 23.0,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text("Voice",
            style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Stolzl',
              ),
            ),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.font,
          size: 23.0,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text("Text",
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Stolzl',
            ),
          ),
        ),
      )
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _navBarItems,
      currentIndex: _currentTab,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: _onTapNavBar,
    );

    return Scaffold(
      body: SafeArea(
        child: _listPage[_currentTab]
      ),

      bottomNavigationBar: _bottomNavBar,
    );
  }
}