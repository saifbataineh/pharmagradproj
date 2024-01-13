import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:grad_test_1/ApplicationPages/camera%20recognition/ocr.dart/result_screen.dart';
import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    this.barcode = "",
    this.name = "",
    this.sci = "",
    this.price1 = "have no available price ",
    this.price2 = "have no available price ",
    this.price3 = "have no available price ",
    this.pack = "",
  });
  final String name;
  final String barcode;
  final String sci;
  final String price1;
  final String price2;
  final String price3;
  final String pack;

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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.volume_up),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/imgs/${name.trim()}.png',fit:BoxFit.fill )),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        iconColor: Colors.deepPurpleAccent,
                        leading: const Icon(Icons.attach_money_outlined),
                        title: const Text("Jordanian public price"),
                        subtitle: Text("$price1 \$"),
                      ),
                      ListTile(
                        iconColor: Colors.deepPurpleAccent,
                        leading: const Icon(Icons.attach_money_outlined),
                        title: const Text("Hospital price"),
                        subtitle: Text("$price2 \$"),
                      ),
                      ListTile(
                        iconColor: Colors.deepPurpleAccent,
                        leading: const Icon(Icons.attach_money_outlined),
                        title: const Text("Pharmacist price"),
                        subtitle: Text("$price3 \$"),
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
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(border:Border(top: BorderSide(width: 20)) ,),
                
                child: ListView.separated(
                    separatorBuilder: (context, _) => const SizedBox(
                          width: 20,
                        ),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: matchingDrugs.length,
                    itemBuilder: (context, index) {
                      final drugName = matchingDrugs[index]['name'];
                      final pack = matchingDrugs[index]['pack'];
                      final price1 = matchingDrugs[index]['generalPrice'];
                      final price2 = matchingDrugs[index]['hospitalPrice'];
                      final price3 = matchingDrugs[index]['pharmaPrice'];
                      final barcode = matchingDrugs[index]['barCode'];
                      final sci = matchingDrugs[index]['sci'];
                
                      return 
                      GestureDetector(
                        onTap: () =>
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>
                        DetailsPage(barcode: barcode,
                        sci: sci,
                        name: drugName,
                        pack: pack,
                        price1: price1,
                        price2: price2,
                        price3: price3,
                        )
                        )) ,
                        child: SizedBox(
                            
                            height: 100,
                            width: 100,
                            child: Column(
                              
                              children:[
                                Text(drugName),
                                Spacer(),
                                SizedBox(
                                  height: 60,
                                  width: double.infinity,
                                  child: Image.asset('assets/imgs/${drugName}.png',fit: BoxFit.fill,))
                              ] ,
                            )),
                      );
                    }),
              )
                    ],
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
