import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TextProvider extends ChangeNotifier {
  String _text = "";

  String get text => _text;

  void setText(String text) {
    _text = text;
    notifyListeners();
  }
}