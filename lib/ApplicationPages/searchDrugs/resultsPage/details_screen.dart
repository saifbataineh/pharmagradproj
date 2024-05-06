import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/maps/drug_location.dart';
import 'package:grad_test_1/ApplicationPages/searchDrugs/resultsPage/fab.dart';
import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:grad_test_1/generated/l10n.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage(
      {super.key,
      this.barcode = "",
      this.name = "",
      this.sci = "",
      this.price1 = "have no available price ",
      this.price2 = "have no available price ",
      this.price3 = "have no available price ",
      this.pack = "",
      this.uses = "",
      this.sideEffects = "",
      this.lang});
  final String name;
  final String barcode;
  final String sci;
  final String price1;
  final String price2;
  final String price3;
  final String pack;
  final String uses;
  final String sideEffects;
  final String? lang;
  
  Future<String> getImageURL() async {
    final reference =
        FirebaseStorage.instance.ref().child('${name.trim()}.png');

    final url = await reference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    context.read<TextProvider>().fetchData;
    return Consumer<TextProvider>(builder: (context, provider, child) {
      if (provider.map.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 54, 212, 244),
          ),
        );
      }
      final drugsData = provider.map['drugs'] as List<dynamic>;
      final matchingDrugs = drugsData.where((drug) {
        return drug['sci'] == sci;
      }).toList();

      return Scaffold(
          appBar: AppBar(
            title: Text(name),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 0.5),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (cxt) =>
                                LocateDrugPage(searchedDrug: name)));
                      },
                      icon: const Icon(Icons.location_on))),
            ],
          ),
          floatingActionButton: DraggableFAB(
            lang: lang,
              text: lang =='en'?"uses are $uses and the side effects are $sideEffects":'الاستخدامات هي $uses والاعراض الجانبية هي $sideEffects'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      
                      children: [
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: FutureBuilder(
                                future: getImageURL(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return CachedNetworkImage(
                                      imageUrl: snapshot.data as String,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                })),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(
                                  width: 2, color: Colors.deepPurpleAccent)),
                          child: ListTile(
                            iconColor: Colors.deepPurpleAccent,
                            leading: const Icon(Icons.account_circle),
                            title: Text(S.of(context).uses),
                            subtitle: Text(uses.trim()),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(
                                  width: 2, color: Colors.deepPurpleAccent)),
                          child: ListTile(
                            iconColor: Colors.deepPurpleAccent,
                            leading: const Icon(Icons.six_k_rounded),
                            title: Text(S.of(context).SideEffects),
                            subtitle: Text(sideEffects),
                          ),
                        ),
                        ListTile(
                          iconColor: Colors.deepPurpleAccent,
                          leading: const Icon(Icons.attach_money_outlined),
                          title: Text(S.of(context).jor_price),
                          subtitle: Text("$price1 jod"),
                        ),
                        ListTile(
                          iconColor: Colors.deepPurpleAccent,
                          leading: const Icon(Icons.account_balance),
                          title: Text(S.of(context).hos_price),
                          subtitle: Text("$price2 jod"),
                        ),
                        ListTile(
                          iconColor: Colors.deepPurpleAccent,
                          leading: const Icon(Icons.attach_money_outlined),
                          title: Text(S.of(context).ph_price),
                          subtitle: Text("$price3 jod"),
                        ),
                        ListTile(
                          iconColor: Colors.deepPurpleAccent,
                          leading: const Icon(Icons.numbers),
                          title: Text(S.of(context).packing),
                          subtitle: Text(pack),
                        ),
                        ListTile(
                          iconColor: Colors.deepPurpleAccent,
                          leading: const Icon(Icons.science),
                          title: Text(S.of(context).generic_name),
                          subtitle: Text(sci),
                        ),
                        ListTile(
                          iconColor: Colors.deepPurpleAccent,
                          leading: const Icon(Icons.barcode_reader),
                          title: Text(S.of(context).barcoden),
                          subtitle: Text(barcode),
                        ),
                        Text(S.of(context).alter,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        Container(
                          height: 150,
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(
                                  width: 2, color: Colors.deepPurpleAccent),),
                          child: ListView.separated(
                              separatorBuilder: (context, _) => const SizedBox(
                                    width: 20,
                                  ),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: matchingDrugs.length,
                              itemBuilder: (context, index) {
                                final drugName = matchingDrugs[index]['name'];
                                Future<String> getImageURL() async {
                                  final reference = FirebaseStorage.instance
                                      .ref()
                                      .child('${drugName.trim()}.png');

                                  final url = await reference.getDownloadURL();
                                  return url;
                                }

                                final pack = matchingDrugs[index]['pack'];
                                final price1 =
                                    matchingDrugs[index]['generalPrice'];
                                final price2 =
                                    matchingDrugs[index]['hospitalPrice'];
                                final price3 =
                                    matchingDrugs[index]['pharmaPrice'];
                                final barcode = matchingDrugs[index]['barCode'];
                                final sci = matchingDrugs[index]['sci'];
                                final uses =lang=='ar'?matchingDrugs[index]['usesArabic']: matchingDrugs[index]['uses'];
                                final sideEffects =lang=='ar'?matchingDrugs[index]['effectsArabic']:
                                    matchingDrugs[index]['side_effects'];
                                return GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (ctx) => DetailsPage(
                                                barcode: barcode,
                                                sci: sci,
                                                name: drugName,
                                                pack: pack,
                                                price1: price1,
                                                price2: price2,
                                                price3: price3,
                                                uses: uses,
                                                sideEffects: sideEffects,
                                              ))),
                                  child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text(drugName),
                                          const Spacer(),
                                          SizedBox(
                                              height: 60,
                                              width: double.infinity,
                                              child: FutureBuilder(
                                                future: getImageURL(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      imageUrl: snapshot.data
                                                          as String,
                                                      placeholder: (context,
                                                              url) =>
                                                          const CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                        'Error: ${snapshot.error}');
                                                  } else {
                                                    return const CircularProgressIndicator();
                                                  }
                                                },
                                              ))
                                        ],
                                      )),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
