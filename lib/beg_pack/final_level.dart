import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';



class FinalLevel extends StatelessWidget {
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
          child: _Pagef(),
        ),
      ),
    );
  }
}

class _Pagef extends StatefulWidget {
  @override
  __PagefState createState() => __PagefState();
}

class __PagefState extends State<_Pagef> {
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
                child: AppBar(
                  iconTheme: IconThemeData.fallback(),
                  backgroundColor: Colors.green[300],
                  elevation: 0,
                  title: Text(
                    "Final Level",
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
                alignment: Alignment.center,
                constraints: BoxConstraints.tightForFinite(width: 250),
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
                glowColor: Theme.of(context).accentColor,
                endRadius: 40,
                duration: Duration(milliseconds: 2000),
                repeatPauseDuration: Duration(milliseconds: 100),
                repeat: true,
                child: NeumorphicButton(
                  onPressed: () => onListen(),
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
