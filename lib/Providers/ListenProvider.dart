import 'package:flutter/material.dart';

class TextProvider extends ChangeNotifier {
  String _text = "";

  String get text => _text;

  void setText(String text) {
    _text = text;
    notifyListeners();
  }
}