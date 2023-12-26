import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/barcode/barcode.dart';
import 'package:grad_test_1/ApplicationPages/camera%20recognition/ocr.dart/optiocal_char_reco.dart';
import 'package:grad_test_1/ApplicationPages/welcome_page/pop_restric.dart';
import 'package:grad_test_1/ApplicationPages/text_voice_page/text_voice_page.dart';
import 'package:grad_test_1/sign-in-up-page/welcome_page.dart';


class FeatureSelector extends StatelessWidget {
  const FeatureSelector({super.key});

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
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const PopRestrict(),
          Image.asset("assets/welcomepage.png"),
          Card(
            borderOnForeground: true,
            child: ListTile(
                splashColor: Colors.deepOrange,
                title: const Text(" Search by voice or text"),
                leading: const Column(
                  children: [
                    Icon(Icons.text_fields),
                    Icon(Icons.headset_mic_rounded),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const MainPage()));
                }),
          ),
          Card(
            borderOnForeground: true,
            child: ListTile(
                title: const Text(" search by name using camera"),
                leading: const Icon(Icons.camera_alt),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const OpitcalChar()));
                }),
          ),
          Card(
              borderOnForeground: true,
              child: ListTile(
                  title: const Text(" search by barcode using camera"),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (cxt) => const BarCodePage()));
                  },
                  leading: const Icon(Icons.barcode_reader)))
        ]));
  }
}
