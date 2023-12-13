import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/pop_restric.dart';
import 'package:grad_test_1/ApplicationPages/text_voice_page/text_voice_page.dart';

class FeatureSelector extends StatelessWidget {
  const FeatureSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              PopRestrict(),
      Image.asset("assets/welcomepage.png"),
      Card(
        borderOnForeground: true,
        child: ListTile(
          splashColor: Colors.deepOrange,
          
            title: Text(" Search by voice or text"),
            leading: Column(
              children: [
                Icon(Icons.text_fields),
                Icon(Icons.headset_mic_rounded),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => MainPage()));
            }),
      ),
      Card(
          borderOnForeground: true,
          child: ListTile(
              title: Text(" search by name using camera"),
              leading: Icon(Icons.camera_alt))),
      Card(
          borderOnForeground: true,
          child: ListTile(
              title: Text(" search by barcode using camera"),
              leading: Icon(Icons.barcode_reader)))
    ]));
  }
}
