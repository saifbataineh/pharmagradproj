import 'package:flutter/material.dart';


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
            if (fruitTextEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return _fruitOptions.where((String option) {
              return option.contains(fruitTextEditingValue.text.toLowerCase());
              
            });
          },
          onSelected: (String value) {
            debugPrint('You just selected $value');
          },
        ),
      ],
    );
  }
}
