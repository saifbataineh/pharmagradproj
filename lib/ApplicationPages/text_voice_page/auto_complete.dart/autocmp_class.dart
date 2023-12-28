import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:provider/provider.dart';

class AutoCompleteSearch extends StatefulWidget {
  const AutoCompleteSearch({super.key});

  @override
  State<AutoCompleteSearch> createState() => _AutoCompleteSearchState();
}

class _AutoCompleteSearchState extends State<AutoCompleteSearch> {
  final controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<TextProvider>().fetchData;
    return Consumer<TextProvider>(builder: (context, provider, child) {
      controller.text = provider.text;
      return provider.map.isEmpty
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("enter Fruit name:"),
                RawAutocomplete<String>(
                    focusNode: focusNode,
                    textEditingController: controller,
                    optionsBuilder: (TextEditingValue fruitTextEditingValue) {
                      final input = fruitTextEditingValue.text.toLowerCase();
                      final drugsData = provider.map['drugs'] as List<dynamic>;

                      // Filter drugs based on input and extract name and pack
                      final matchingDrugs = drugsData
                          .where((drug) => drug['name']
                              .toLowerCase()
                              .contains(input.toLowerCase()))
                          .map((drug) =>
                              {'name': drug['name'], 'pack': drug['pack']})
                          .toList();

                      // Return a list of formatted strings with name and pack
                      return matchingDrugs
                          .map((drug) => '${drug['name']} - ${drug['pack']}')
                          .toList();
                    },
                    onSelected: (String value) {
                      debugPrint('You just selected $value');
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final drugName =
                                            options.elementAt(index);
                                        final parts = drugName.split('-');
                                        final name = parts[0];
                                        final pack = parts[1];

                                        return GestureDetector(
                                            onTap: () {
                                              onSelected(name);
                                            },
                                            child: ListTile(
                                              title: Text(name),
                                              subtitle: Text(pack),
                                            ));
                                      }))));
                    })
              ],
            );
    });
  }
}
