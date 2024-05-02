import 'package:flutter/material.dart';

import 'package:grad_test_1/generated/l10n.dart';
import 'package:grad_test_1/sign-in-up-page/sign_in_up.dart';

import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  final Locale? currentLocale;
  final Function(Locale)? onLanguageChange;
  const WelcomePage({super.key, this.currentLocale, this.onLanguageChange});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late SharedPreferences _prefs;
  late String? hello;

  @override
  void initState() {
    getinit();
    super.initState();
  }

  getinit() async {
    _prefs = await SharedPreferences.getInstance();
    
  }

  Future<void> _changeLanguage(Locale locale) async {
    final prefs = _prefs;
  
    
    await prefs.setString('language_code', locale.languageCode);
    widget.onLanguageChange!(locale);
  }

  @override
  Widget build(BuildContext context) {
    hello = _prefs.getString("language_code");
    return Scaffold(
        appBar: AppBar(
            title:  Text(
          S.of(context).pharmaTails,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/welcomePage1.png",
          ),
          SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const SignInForm()));
                  },
                  child: Text(
                    S.of(context).login,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ))),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => const SignUp()));
                  },
                  child: Text(
                    S.of(context).SignUp,
                  ))),
          hello == 'ar'
              ? ElevatedButton(
                  onPressed: () {
                    _changeLanguage(Locale('en'));
                    setState(() {});
                  },
                  child: Text(S.of(context).lagn),
                )
              : // Add spacing between buttons
              ElevatedButton(
                  onPressed: () {
                    _changeLanguage(Locale('ar'));
                    setState(() {});
                  },
                  child: Text(S
                      .of(context)
                      .lagn)), // Use Arabic text for the Arabic button
        ]));
  }
}
