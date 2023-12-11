import 'package:avatar_glow/avatar_glow.dart';

import 'package:flutter/material.dart';
import 'package:grad_test_1/Providers/ListenProvider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceRecognition extends StatefulWidget {
  const VoiceRecognition({super.key});

  @override
  State<VoiceRecognition> createState() => _VoiceRecognitionState();
}

class _VoiceRecognitionState extends State<VoiceRecognition> {
  SpeechToText speechtoTect = SpeechToText();
  var _isListening = false;
  var text = "hold the button and start speaking";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        AvatarGlow(
          endRadius: 75.0,
          animate: _isListening,
          duration: const Duration(milliseconds: 10000),
          glowColor: Colors.green,
          repeat: true,
          repeatPauseDuration: const Duration(milliseconds: 100),
          showTwoGlows: true,
          child: GestureDetector(
            onTapDown: (details) {
              setState(() async {
                if (!_isListening) {
                  var available = await speechtoTect.initialize();
                  if (available) {
                    _isListening = true;
                    speechtoTect.listen(onResult: (result) {
                      final provider =
                          Provider.of<TextProvider>(context, listen: false);
                      setState(() {
                        text = result.recognizedWords;
                        provider.setText(text);
                      });
                    });
                  }
                }
              });
            },
            onTapUp: (details) {
              setState(() {
                _isListening = false;
              });
              speechtoTect.stop();
            },
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 35,
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
