import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/mainPage/auto_complete.dart/autocmp_class.dart';
import 'package:grad_test_1/mainPage/pop_restric.dart';
import 'package:grad_test_1/sign-in-up-page/welcome_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 0.5),
              child: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const WelcomePage()), (route) => false);
                  },
                  icon: const Icon(Icons.logout)))
        ],
      ),
      body: const Column(children: [
        AutoCompleteSearch(),

        PopRestrict(),
      ],
        
        
      ),
    );
  }
}
