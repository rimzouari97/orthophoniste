import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:orthophoniste/beg_pack/custom_dialog.dart';
import 'package:orthophoniste/beg_pack/level2.dart';

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        defaultTextColor: Color(0xFF3E3E3E),
        accentColor: Colors.grey,
        variantColor: Colors.black38,
        depth: 8,
        intensity: 0.65,
      ),
      themeMode: ThemeMode.light,
      child: Material(
        child: NeumorphicBackground(
          child: _Page1(),
        ),
      ),
    );
  }
}

class _Page1 extends StatefulWidget {
  @override
  __Page1State createState() => __Page1State();
}

class __Page1State extends State<_Page1> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _textSpeech = 'hit record to start the game';
  String _correct = 'hit record to start the game';
  //must got glad that grandad had flat hat

  void onListen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
            onResult: (val) => setState(() {
                  _textSpeech = val.recognizedWords;
                }));
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  List<String> words = [
    'Must',
    'Got',
    'Glad',
    'That',
    'Grandad',
    'Had',
    'flat',
    'hat'
  ];

  @override
  Widget _buildButton({String text, VoidCallback onClick}) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
        color: Colors.blue[300],
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        shape: NeumorphicShape.flat,
      ),
      child: Center(child: Text(text)),
      onPressed: onClick,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Neumorphic(
                child: AppBar(
                  iconTheme: IconThemeData.fallback(),
                  backgroundColor: Colors.blue[300],
                  elevation: 0,
                  title: Text(
                    "First Level",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                style: NeumorphicStyle(
                  depth: -8,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Lottie.network(
                    'https://assets10.lottiefiles.com/packages/lf20_ofa3xwo7.json'),
                alignment: Alignment.topCenter,
                constraints: BoxConstraints.tightForFinite(width: 250),
              ),
              SizedBox(
                height: 20,
              ),
              Neumorphic(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                style: NeumorphicStyle(
                  color: Colors.grey[200],
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                ),
                child: Text(
                  _textSpeech,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.defaultTextColor,
                  ),
                ),
              ),
              Neumorphic(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                style: NeumorphicStyle(
                  color: Colors.grey[300],
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildButton(
                              text: words[0],
                              onClick: () {
                                print('audio playing');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildButton(
                              text: words[1],
                              onClick: () {
                                print('audio playing');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildButton(
                              text: words[2],
                              onClick: () {
                                print('audio playing');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildButton(
                              text: words[3],
                              onClick: () {
                                print('audio playing');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildButton(
                              text: words[4],
                              onClick: () {
                                print('audio playing');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildButton(
                              text: words[5],
                              onClick: () {
                                print('audio playing');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildButton(
                              text: words[6],
                              onClick: () {
                                print('audio playing');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildButton(
                              text: words[7],
                              onClick: () {
                                print('audio playing');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              AvatarGlow(
                animate: _isListening,
                glowColor: Theme.of(context).primaryColor,
                endRadius: 40,
                duration: Duration(milliseconds: 2000),
                repeatPauseDuration: Duration(milliseconds: 100),
                repeat: true,
                child: NeumorphicButton(
                  onPressed: () async {
                    await onListen();
                    if (_correct.compareTo(_textSpeech.toLowerCase()) == 0) {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          title: "Amazing!",
                          description:
                              "we have dealt with \'A\' words and in the next level we will have \'i\' words, are you ready!",
                          buttonText: "Yes I am",
                        ),
                      );
                      await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        print('hurray');
                        return Level2();
                      }));
                    } else {
                      await print('fail');
                    }
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
