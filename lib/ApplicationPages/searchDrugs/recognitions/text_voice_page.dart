import 'package:flutter/material.dart';

import 'package:grad_test_1/ApplicationPages/searchDrugs/recognitions/autocmp_class.dart';

import 'package:grad_test_1/ApplicationPages/searchDrugs/recognitions/recognitions/voicerec/voice_recognition.dart';



class VoiceTextSearch extends StatelessWidget {
  const VoiceTextSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:   Column(
        children: [
          AutoCompleteSearch(),
          const Spacer(),
          const VoiceRecognition(),
        ],
      ),
    );
  }
}
