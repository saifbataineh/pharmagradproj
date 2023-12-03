import 'package:flutter/material.dart';
import 'package:grad_test_1/classesInsidePages/sign_in_up.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
            "PharmaTails",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          "assets/welcomePage1.png",
        ),
        SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const SignInForm()));
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ))),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const SignUp()));
                },
                child: const Text(
                  "SignUp",
                )))
      ]),
    );
  }
}
