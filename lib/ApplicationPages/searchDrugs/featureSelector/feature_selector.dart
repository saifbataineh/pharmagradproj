import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/searchDrugs/barcode/barcode.dart';
import 'package:grad_test_1/ApplicationPages/searchDrugs/recognitions/recognitions/camera%20recognition/ocr.dart/optiocal_char_reco.dart';
import 'package:grad_test_1/ApplicationPages/searchDrugs/recognitions/text_voice_page.dart';



class FeatureSelector extends StatelessWidget {
  const FeatureSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          
          Image.asset("assets/welcomepage.png"),
          Card(
            borderOnForeground: true,
            child: ListTile(
                splashColor: Colors.deepOrange,
                title: const Text("Search for Drugs via Voice or Text"),
                leading: const Column(
                  children: [
                    Icon(Icons.text_fields),
                    Icon(Icons.headset_mic_rounded),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const VoiceTextSearch()));
                }),
          ),
          Card(
            borderOnForeground: true,
            child: ListTile(
                title: const Text(" search by name using camera"),
                leading: const Icon(Icons.add_a_photo),
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
