import 'package:flutter/material.dart';
import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    context.read<TextProvider>().fetchData;
    return Consumer<TextProvider>(builder: (context, provider, child) {
      final drugsData = provider.map['drugs'] as List<dynamic>;
      final matchingDrugs = drugsData.where((drug) {
        final drugNameLower = drug['name'].toLowerCase();
        final textLower = text.toLowerCase();

        return textLower.contains(drugNameLower);
      }).toList();
      return Scaffold(
          appBar: AppBar(
            title: const Text("Result"),
          ),
          body: ListView.builder(
              itemCount: matchingDrugs.length,
              itemBuilder: (context, index) {
                final drugName = matchingDrugs[index]['name'];
                final pack = matchingDrugs[index]['pack'];
                return ListTile(
                  title: Text(drugName),
                  subtitle: Text(pack),
                );
              }));
    });
  }
}
