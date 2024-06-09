import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextProvider extends ChangeNotifier {
  String _text = "";
  Locale _locale = const Locale('ar');
  Locale get locale => _locale;
  Future<void> fetchLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _locale = const Locale("ar");
      return null;
    }
    _locale = Locale(prefs.getString("language_code")!);

    notifyListeners();
    return null;
  }

  void changeLanguage(Locale type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    if (type == const Locale("ar")) {
      _locale = const Locale("ar");
      await prefs.setString('language_code', 'ar');
    } else {
      _locale = const Locale("en");
      await prefs.setString('language_code', 'en');
    }
    notifyListeners();
  }

  Map<String, dynamic> _map = {};

  String get text => _text;

  Future<void> get fetchData async {
    final String response =
        await rootBundle.loadString('assets/json/datapharma.json');

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
