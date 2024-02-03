import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/Category/pop_restric.dart';
import 'package:grad_test_1/ApplicationPages/dosage%20reminder/dose.dart';
import 'package:grad_test_1/ApplicationPages/searchDrugs/featureSelector/feature_selector.dart';
import 'package:grad_test_1/sign-in-up-page/welcome_page.dart';
import 'package:grad_test_1/ApplicationPages/maps/google_maps.dart';

class CategorySelector extends StatelessWidget {
  CategorySelector({super.key});

  final List<IconData> icons = [
    Icons.local_pharmacy_outlined,
    Icons.search,
    Icons.access_alarm,
    Icons.border_color,
  ];
  final List<String> texts = [
    "Nearest pharmacies",
    "Search for your drug",
    "Set alarm for drug doses",
    "your records",
  ];

  final List<Widget> pages = [
    const MapPage(),
    const FeatureSelector(),
    const Dose(),
    const Text("i love the world "),
  ]; // Your list of icons

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: pages.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              physics: ClampingScrollPhysics(),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: texts[0],
                    icon: Icon(icons[0]),
                  ),
                  Tab(
                    text: texts[1],
                    icon: Icon(icons[1]),
                  ),
                  Tab(
                    text: texts[2],
                    icon: Icon(icons[2]),
                  ),
                  Tab(
                    text: texts[3],
                    icon: Icon(icons[3]),
                  ),
                ]),
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
          body: TabBarView(
            physics:NeverScrollableScrollPhysics(),
            children: pages,
          ),
        ));
  }
}
