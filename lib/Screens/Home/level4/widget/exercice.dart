import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Exercice extends StatefulWidget {
  @override
  _TextToSpeechState createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<Exercice> {

  VoiceController controller = FlutterTextToSpeech.instance.voiceController();
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    controller.init();

  }
  final Map<String, HighlightedWord> _highlights = {
    'Rouge': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };


  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Tap the button and start speaking';
  String _text1 = 'Rouge';
  double _confidence = 1.0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child:
            Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontFamily: 'Stolzl',
                )
            )
        ),),


      body: Column (
        children: [ SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: TextHighlight(
                  text: _text,
                  words: _highlights,
                  textStyle: const TextStyle(
                      fontSize: 32.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Stolzl'
                  ),
                ),
              ),
            ),

              Center(
                child: Row(
                  children: [
                    AvatarGlow(
                      animate: false,
                      glowColor: Theme.of(context).primaryColor,
                      endRadius: 50.0,
                      duration: const Duration(milliseconds: 2000),
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      repeat: true,
                      child: FloatingActionButton(
                        onPressed: () {
                          //  controller.speak("${textController.text}");
                          controller.setLanguage("fr-FR");
                          controller.speak(_text1);
                        },
                        child: Icon(Icons.volume_up),
                      ),
                    ),




                    AvatarGlow(
                      animate: _isListening,
                      glowColor: Theme.of(context).primaryColor,
                      endRadius: 50.0,
                      duration: const Duration(milliseconds: 2000),
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      repeat: true,
                      child: FloatingActionButton(
                        onPressed: _listen,
                        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                      ),
                    ),

                  ],
                ),
              )

        ],
      ),
    );
  }
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}