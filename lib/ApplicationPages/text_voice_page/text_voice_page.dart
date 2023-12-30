import 'package:flutter/material.dart';
import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:grad_test_1/ApplicationPages/text_voice_page/auto_complete.dart/autocmp_class.dart';

import 'package:grad_test_1/ApplicationPages/text_voice_page/recognitions/voice_recognition.dart';

import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          AutoCompleteSearch(),
          Spacer(),
          VoiceRecognition(),
        ],
      ),
    );
  }
}
