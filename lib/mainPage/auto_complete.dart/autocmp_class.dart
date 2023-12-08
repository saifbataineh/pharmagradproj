import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
class AutoCompleteSearch extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("enter Fruit name:"),
        Autocomplete<String>(
          
          optionsBuilder: (TextEditingValue fruitTextEditingValue) {
            final  input = fruitTextEditingValue.text.toLowerCase();
            final filteredOptions = _fruitOptions
        .where((option) => ratio(input, option) > 30)
        .toList(growable: false);
        filteredOptions.sort((a, b) => ratio(b, input).compareTo(ratio(a, input)));
    return filteredOptions;
          },
          onSelected: (String value) {
            debugPrint('You just selected $value');
          },
        ),
      ],
    );
  }
}
