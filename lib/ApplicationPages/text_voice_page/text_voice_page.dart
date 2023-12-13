import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/Providers/ListenProvider.dart';
import 'package:grad_test_1/ApplicationPages/text_voice_page/auto_complete.dart/autocmp_class.dart';

import 'package:grad_test_1/ApplicationPages/text_voice_page/recognitions/voice_recognition.dart';
import 'package:grad_test_1/sign-in-up-page/welcome_page.dart';
import 'package:provider/provider.dart';

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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => const WelcomePage()),
                          (route) => false);
                    },
                    icon: const Icon(Icons.logout)))
          ],
        ),
        body: 
           ChangeNotifierProvider(create: (_)=>TextProvider(),
             child: const Column(
              children: [
                
                AutoCompleteSearch(),
                Spacer(),
                VoiceRecognition(),
                
              ],
                       ),
           ));
        }
  }

