import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:provider/provider.dart';

class AutoCompleteSearch extends StatefulWidget {
  const AutoCompleteSearch({super.key});
  static const List<String> _fruitOptions = <String>[
    'apple',
    'banana',
    'orange',
    'mango',
    'grapes',
    'watermelon',
    'kiwi',
    'strawberry',
    'sugarcane',
  ];

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
    return Consumer<TextProvider>(builder: (context, provider, child) {
      controller.text = provider.text;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("enter Fruit name:"),
          RawAutocomplete<String>(
              focusNode: focusNode,
              textEditingController: controller,
              optionsBuilder: (TextEditingValue fruitTextEditingValue) {
                final input = fruitTextEditingValue.text.toLowerCase();

                final filteredOptions = AutoCompleteSearch._fruitOptions
                    .where((option) => ratio(input, option) > 25)
                    .toList(growable: false);
                filteredOptions
                    .sort((a, b) => ratio(b, input).compareTo(ratio(a, input)));

                return filteredOptions;
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
                Iterable<String> options,
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
                                itemBuilder: (BuildContext context, int index) {
                                  final String option =
                                      options.elementAt(index);
                                  return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(option),
                                      ));
                                }))));
              })
        ],
      );
    });

  }

}

