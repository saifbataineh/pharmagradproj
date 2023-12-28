import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextProvider extends ChangeNotifier {
  String _text = "";

  Map<String, dynamic> _map = {};

  String get text => _text;

  Future<void> get fetchData async {
    final String response =
        await rootBundle.loadString('assets/json/datapharma.json') ;

    _map = await json.decode(response);
    
    notifyListeners();
  }

  void initialValues() {
    _map = {};
    notifyListeners();
  }

  Map<String, dynamic> get map => _map;

  void setText(String text) {
    _text = text;
    notifyListeners();
  }
}
