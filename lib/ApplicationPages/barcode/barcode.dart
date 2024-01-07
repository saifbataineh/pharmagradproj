
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grad_test_1/ApplicationPages/resultsPage/details_screen.dart';
import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BarCodePage extends StatefulWidget {
  const BarCodePage({super.key});

  @override
  State<BarCodePage> createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  String result = "";
  List _items = [];
  String tryA = "";
  @override
  Widget build(BuildContext context) {
    context.read<TextProvider>().fetchData;
    return Consumer<TextProvider>(builder: (context, provider, child) {
      return Scaffold(
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            ElevatedButton(
                onPressed: () async {
                  var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SimpleBarcodeScannerPage(),
                      ));

                  if (res is String) {
                    setState(() {
                      result = res;
                      _items =
                          provider.map['drugs']; // Assuming data is loaded elsewhere

                      for (var drug in _items) {
                        if (drug['barCode'] == result) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                barcode: result,
                                name: drug["name"],
                                sci: drug["sci"] as String,
                                price1: drug["generalPrice"],
                                price2: drug["hospitalPrice"],
                                price3: drug["pharmaPrice"],
                                pack: drug["pack"],
                              ),
                            ),
                          );
                          return; // Exit the loop after navigation
                        }
                      }
                    });
                  }
                },
                child: result.isEmpty
                    ? const Text('Open Scanner  ')
                    : const Text(
                        "no bar code were found please try again",
                        style:
                            TextStyle(color: Color.fromARGB(255, 168, 42, 13)),
                      ))
          ])));
    });
  }
}
