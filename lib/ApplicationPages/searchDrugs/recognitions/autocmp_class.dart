import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:grad_test_1/ApplicationPages/searchDrugs/resultsPage/details_screen.dart';
import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:grad_test_1/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class AutoCompleteSearch extends StatelessWidget {
   AutoCompleteSearch({super.key});

  final controller = TextEditingController();

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    context.read<TextProvider>().fetchData;
    return Consumer<TextProvider>(builder: (context, provider, child) {
      controller.text = provider.text;
      return SafeArea(
          child: provider.map.isEmpty
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).searchInput,
                      style: const TextStyle(fontSize: 15),
                    ),
                    RawAutocomplete<String>(
                        focusNode: focusNode,
                        textEditingController: controller,
                        optionsBuilder:
                            (TextEditingValue drugTextEditingValue) {
                          final input = drugTextEditingValue.text.toLowerCase();
                          final drugsData =
                              provider.map['drugs'] as List<dynamic>;

                          // Filter drugs based on input and extract name and pack
                          final matchingDrugs = drugsData.where((drug) {
                            final drugNameLower = drug['name']
                                .toLowerCase()
                                .toString()
                                .split(" ")
                                .first;
                            return ratio(drugNameLower.toLowerCase(),
                                    input.toLowerCase()) >=
                                50;
                          }) // Adjust threshold as needed

                              .toList()
                            ..sort((drug1, drug2) => partialRatio(
                                    drug2['name'].toLowerCase(),
                                    input.toLowerCase())
                                .compareTo(partialRatio(
                                    drug1['name'].toLowerCase(),
                                    input.toLowerCase())));

                          return matchingDrugs
                              .map((drug) =>
                                  '${drug['name']} --${drug['generalPrice']}--${drug['hospitalPrice']}--${drug['pharmaPrice']}-- ${drug['pack']} --${drug['sci']} --${drug['barCode']} -- ${Intl.getCurrentLocale()=='ar' ? drug['usesArabic'] : drug['uses']} --${Intl.getCurrentLocale()=='ar' ? drug['effectsArabic'] : drug['side_effects']}')
                              .toList();
                        },
                        fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted,
                        ) {
                          return TextFormField(
                              autofocus: true,
                              canRequestFocus: true,
                              controller: textEditingController,
                              focusNode: focusNode,
                              onFieldSubmitted: (String value) {
                                onFieldSubmitted();
                              });
                        },
                        optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          options,
                        ) {
                          return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                  elevation: 4.0,
                                  child: SizedBox(
                                      height: 200.0,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(8.0),
                                          itemCount: options.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final drugName =
                                                options.elementAt(index);
                                            final parts = drugName.split('--');
                                            final name = parts[0];
                                            final price1 = parts[1];
                                            final price2 = parts[2];
                                            final price3 = parts[3];
                                            final pack = parts[4];
                                            final sci = parts[5].trim();
                                            final barcode = parts[6];
                                            final uses = parts[7];
                                            final sidee = parts[8];

                                            return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              DetailsPage(
                                                                pack: pack,
                                                                name: name,
                                                                price1: price1,
                                                                price2: price2,
                                                                price3: price3,
                                                                sci: sci,
                                                                barcode:
                                                                    barcode,
                                                                sideEffects:
                                                                    sidee,
                                                                uses: uses,
                                                                
                                                              )));
                                                },
                                                child: ListTile(
                                                  title: Text(name),
                                                  subtitle:
                                                      Text("Packing: $pack"),
                                                ));
                                          }))));
                        })
                  ],
                ));
    });
  }
}
