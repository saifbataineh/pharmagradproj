import 'package:flutter/material.dart';

import 'package:grad_test_1/generated/l10n.dart';
import 'package:grad_test_1/sign-in-up-page/sign_in_up.dart';
import 'package:intl/intl.dart';


class WelcomePage extends StatefulWidget {
  final Locale? currentLocale;
  final  Function(Locale, String)? onLanguageChange;
  const WelcomePage({super.key, this.currentLocale, this.onLanguageChange});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {


  @override
  void initState() {
  
    super.initState();
  }

 

 

  @override
  Widget build(BuildContext context) {
  
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
                            builder: (ctx) =>  SignInForm(currentLocale: widget.currentLocale,onLanguageChange: widget.onLanguageChange,)));
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
                        MaterialPageRoute(builder: (ctx) =>  SignUp(currentLocale: widget.currentLocale,onLanguageChange: widget.onLanguageChange,)));
                  },
                  child: Text(
                    S.of(context).SignUp,
                  ))),
               Intl.getCurrentLocale()=='ar'
          //hello == 'ar'
              ? ElevatedButton(
                  onPressed: () {

                    widget.onLanguageChange!(const Locale('en'),"en");
                    setState(() {});
                  },
                  child: Text(S.of(context).lagn),
                )
              : // Add spacing between buttons
              ElevatedButton(
                  onPressed: () {
                   widget.onLanguageChange!(const Locale('ar'),"ar");
                    setState(() {});
                  },
                  child: Text(S
                      .of(context)
                      .lagn)), // Use Arabic text for the Arabic button
        ]));
  }
}
