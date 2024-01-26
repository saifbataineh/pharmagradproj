import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/Category/pop_restric.dart';
import 'package:grad_test_1/ApplicationPages/dosage%20reminder/dose.dart';
import 'package:grad_test_1/ApplicationPages/searchDrugs/featureSelector/feature_selector.dart';
import 'package:grad_test_1/sign-in-up-page/welcome_page.dart';

class CategorySelector extends StatelessWidget {
  CategorySelector({super.key});

  final List<IconData> icons = [
    Icons.search,
    Icons.access_alarm,
    Icons.border_color,
    Icons.local_pharmacy_outlined,
  ];
  final List<String> texts = [
    "Search for your drug",
    "Set alarm for drug doses",
    "your records",
    "Nearest pharmacies"
  ];
  final List<Color> colors = [
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent
  ];
  final List pages = [
    const FeatureSelector(),
    const Dose(),
    const FeatureSelector(),
     const Dose(),
  ]; // Your list of icons

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 0.5),
              child: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (ctx) => const WelcomePage()),
                        (route) => false);
                  },
                  icon: const Icon(Icons.logout)))
        ],
      ),
      body: Column(
        children: [
          const PopRestrict(),
          const Text("Category",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  // Add a border around the entire GridView
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: GridView.builder(
                itemCount: icons.length, // Use the length of the icons list
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final icon = icons[index];
                  final textt = texts[index];
                  final color =
                      colors[index]; // Retrieve the icon for the current tile

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => pages[index]));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      color: color,
                      child: GridTile(
                        header: Text(
                          textt,
                          textAlign: TextAlign.center,
                        ),
                        child: Icon(icon),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
