import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/dosage%20reminder/dose.dart';
import 'package:grad_test_1/ApplicationPages/records/records.dart';
import 'package:grad_test_1/ApplicationPages/searchDrugs/featureSelector/feature_selector.dart';
import 'package:grad_test_1/generated/l10n.dart';
import 'package:grad_test_1/main.dart';
import 'package:grad_test_1/ApplicationPages/maps/google_maps.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
 
    

  final List<IconData> icons = [
    Icons.local_pharmacy_outlined,
    Icons.search,
    Icons.access_alarm,
    Icons.border_color,
  ];

 

  final List<Widget> pages = [
    const MapPage(),
    const FeatureSelector(),
    const Dose(),
    const Records(),
  ]; 
  @override
  void initState() {
    super.initState();
  }
 // Your list of icons
  @override
  Widget build(BuildContext context) {
     final List<String> texts = [
    S.of(context).nearPharma,
    S.of(context).searchDrug,
    S.of(context).alarm,
    S.of(context).records,
  ];
    return DefaultTabController(
        initialIndex: 1,
        length: pages.length,
        child: Scaffold(
          appBar: AppBar(
            title:  Text(S.of(context).pharmaTails),
            bottom: TabBar(
              physics: const ClampingScrollPhysics(),
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
                                builder: (ctx) =>   const MyApp()),
                            (route) => false);
                      },
                      icon: const Icon(Icons.logout)))
            ],
          ),
          body: TabBarView(
            physics:const NeverScrollableScrollPhysics(),
            children: pages,
          ),
        ));
  }
}
