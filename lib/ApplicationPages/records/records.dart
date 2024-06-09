import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/generated/l10n.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  final _currentUserEmail = FirebaseAuth.instance.currentUser?.email;
  late final Stream<DocumentSnapshot>? _usersStream;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _value = TextEditingController();
  String? drug = "Diabetes";
  @override
  void initState() {
    
    super.initState();

    if (_currentUserEmail != null) {
      _usersStream = FirebaseFirestore.instance
          .collection('records')
          .doc(_currentUserEmail)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: StatefulBuilder(
                builder: (context, setState) => Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.5,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).pleaseenter;
                              }
                              return null;
                            },
                            controller: _value,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration:  InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(40, 124, 77, 255),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              hintText: S.of(context).hintR,
                              labelText: S.of(context).hintR,
                              contentPadding: const EdgeInsets.all(6),
                            ),
                          ),
                        ),
                         Text(S.of(context).recordsText),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                   Text(S.of(context).recordsDiabetes,),
                                  Radio(
                                      value: "Diabetes",
                                      groupValue: drug,
                                      onChanged: (val) {
                                        setState(() {
                                          drug = val;
                                        });
                                      }),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                 Text(S.of(context).recordsPressure),
                                Radio(
                                    value: "pressure",
                                    groupValue: drug,
                                    onChanged: (val) {
                                      setState(() {
                                        drug = val;
                                      });
                                    }),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(onPressed: ()async {
                     final now = DateTime.now();
                     
                      final id =
                                  DateTime.now().microsecondsSinceEpoch % 10000;
                     if (_formKey.currentState!.validate()) {
                                await FirebaseFirestore.instance
                                    .collection('records')
                                    .doc(_currentUserEmail)
                                    .set({
                                  id.toString(): {
                                    "value": _value.text,
                                    "type":drug,
                                    "time":now,
                                  }
                                }, SetOptions(merge: true));
                                if (!context.mounted) return;
                                Navigator.of(context).pop();

                                // Ensure alarm triggers even in doze mode
                              }
                }, child:  Text(S.of(context).recordsSave))
              ],
            ),
          );
        },
      ),
      body: StreamBuilder(
          stream: _usersStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return  Text(S.of(context).errorText);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Text(S.of(context).Loading);
            }
            late final Map<String, dynamic> userData;
            try {
              userData = snapshot.data!.data() as Map<String, dynamic>;
            } catch (e) {
              userData = {};
            }

            return userData.isEmpty
                ?  Center(
                    child: Text(S.of(context).Noyet),
                  )
                : ListView.builder(
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      final mapKey = userData.keys.elementAt(index);
                      final mapValue = userData[mapKey] as Map<String, dynamic>;
                      return Card(
                        child: ListTile(
                          subtitle: Text("${S.of(context).sche} ${mapValue["time"].toDate()}"),
                          trailing: Text(
                            " ${mapValue["value"]}",
                            textAlign: TextAlign.center,
                          ),
                          title: Text(mapValue["type"]),
                        ),
                      );
                    });
          }),
    );
  }
}
