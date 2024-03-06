import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/searchDrugs/resultsPage/details_screen.dart';
import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:provider/provider.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    context.read<TextProvider>().fetchData;
    return Consumer<TextProvider>(builder: (context, provider, child) {
      if (provider.map.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 54, 212, 244),
          ),
        );
      }

      final drugsData = provider.map['drugs'] as List<dynamic>;
      final matchingDrugs = drugsData.where((drug) {
        final drugNameLower = drug['name'].toLowerCase(). toString().split(" ").first;
        final textLower = text.toLowerCase();

        return partialRatio(drugNameLower, textLower) == 100;
      }).toList()
      ..sort((drug1, drug2) => partialRatio(drug2['name'].toLowerCase(), text.toLowerCase())
        .compareTo(partialRatio(drug1['name'].toLowerCase(), text.toLowerCase())));
      

      return Scaffold(
        appBar: AppBar(
          title: const Text("Result"),
        ),
        body: ListView.builder(
          itemCount: matchingDrugs.length,
          itemBuilder: (context, index) {
            final drugName = matchingDrugs[index]['name'];
            final pack = matchingDrugs[index]['pack'];
            final sci = matchingDrugs[index]['sci'];
            final joPrice = matchingDrugs[index]['generalPrice'];
            final hospitalPrice = matchingDrugs[index]['hospitalPrice'];
            final phPrice = matchingDrugs[index]['pharmaPrice'];
            final barcode = matchingDrugs[index]['barCode'];
            final uses = matchingDrugs[index]['uses'];
            final sideEffects = matchingDrugs[index]['side_effects'];

            return ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (cxt) => DetailsPage(
                      name: drugName,
                      pack: pack,
                      sci: sci as String,
                      price1: joPrice,
                      price2: hospitalPrice,
                      price3: phPrice,
                      barcode: barcode,
                      uses: uses,
                      sideEffects: sideEffects,
                    ),
                  ),
                );
              },
              title: Text(drugName),
              subtitle: Text(pack),
            );
          },
        ),
      );
    });
  }
}
