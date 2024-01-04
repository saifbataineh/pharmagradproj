import 'package:flutter/material.dart';

import 'package:grad_test_1/ApplicationPages/text_voice_page/auto_complete.dart/autocmp_class.dart';

import 'package:grad_test_1/ApplicationPages/text_voice_page/recognitions/voice_recognition.dart';



class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Column(
        children: [
          AutoCompleteSearch(),
          Spacer(),
          VoiceRecognition(),
        ],
      ),
    );
  }
}
