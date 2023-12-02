import 'package:flutter/material.dart';
import 'package:grad_test_1/classesInsidePages/signInUp.dart';
import 'package:grad_test_1/screens/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter auth',
        theme: ThemeData(
          textButtonTheme: TextButtonThemeData(style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.deepPurpleAccent) )),
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white
        ),
        home: WelcomePage(),
        );
  }
}
