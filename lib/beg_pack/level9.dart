import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:orthophoniste/services/stutter_service.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:orthophoniste/beg_pack/level10.dart';

import 'Beg.dart';
import 'custom_dialog.dart';

class Level9 extends StatelessWidget {
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
          child: _Page9(),
        ),
      ),
    );
  }
}

class _Page9 extends StatefulWidget {
  @override
  __Page9State createState() => __Page9State();
}

class __Page9State extends State<_Page9> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _textSpeech = 'press the button to start speaking';
  String _correct = 'must got glad that grandad had flat hat';

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

  // Future<AudioPlayer> playSound(String _song) async {
  //   AudioCache cache = new AudioCache();
  //   return await cache.play("$_song.mp3");
  // }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  StutterService get stutterservice => GetIt.I<StutterService>();

  List<String> words = [
    'Bad',
    'Glad',
    'Comerade',
    'Grandad',
    'Nomad',
    'Cat',
    'Splat',
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
        color: Colors.green[300],
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        shape: NeumorphicShape.flat,
      ),
      child: Center(child: Text(text)),
      onPressed: onClick,
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: NeumorphicButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Beg();
                }));
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.navigate_before),
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "5th Level",
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    var item = '';
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Neumorphic(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: _buildTopBar(context),
                style: NeumorphicStyle(
                  color: Colors.blue[300],
                  depth: -8,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_AHptq1.json'),
                alignment: Alignment.center,
                constraints: BoxConstraints.tightForFinite(width: 300),
              ),
              Neumorphic(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                style: NeumorphicStyle(
                  color: Colors.grey[200],
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                ),
                child: Align(
                  child: Text(
                    _textSpeech,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: NeumorphicColors.defaultTextColor,
                    ),
                  ),
                  alignment: Alignment.center,
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
                      await StutterService.saveStutterProgress(10);
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
                        return Level10();
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
