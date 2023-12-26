import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    this.barcode = "",
    this.name = "",
    this.sci = "",
    this.Price1 = "have no available price ",
    this.Price2 = "have no available price ",
    this.Price3 = "have no available price ",
    this.pack=""
  });
  final String name;
  final String barcode;
  final String sci;
  final String Price1;
  final String Price2;
  final String Price3;
  final String pack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.volume_up),
        ),
        body: ListView(
          children: [
            ListTile(
              iconColor: Colors.deepPurpleAccent,
              leading: const Icon(Icons.attach_money_outlined),
              title: const Text("Jordanian public price"),
              subtitle: Text("$Price1 \$"),
            ),
            ListTile(
              iconColor: Colors.deepPurpleAccent,
              leading: const Icon(Icons.attach_money_outlined),
              title: const Text("Hospital price"),
              subtitle: Text("$Price2 \$"),
            ),
            ListTile(
              iconColor: Colors.deepPurpleAccent,
              leading: const Icon(Icons.attach_money_outlined),
              title: const Text("Pharmacist price"),
              subtitle: Text("$Price3 \$"),
            ),
            ListTile(
              iconColor: Colors.deepPurpleAccent,
              leading: const Icon(Icons.numbers),
              title: const Text("Packing"),
              subtitle: Text(pack),
            ),
            ListTile(
              iconColor: Colors.deepPurpleAccent,
              leading: const Icon(Icons.science),
              title: const Text("Generic name"),
              subtitle: Text(sci),
            ),
            ListTile(
              iconColor: Colors.deepPurpleAccent,
              leading: const Icon(Icons.barcode_reader),
              title: const Text("barcode"),
              subtitle: Text(barcode),
            ),
         
          ],
        ));
  }
}
