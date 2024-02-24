import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  final _currentUserEmail = FirebaseAuth.instance.currentUser?.email;
  late final Stream<DocumentSnapshot>? _usersStream;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _value = TextEditingController();
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
        child: Icon(Icons.add),
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
                                return "please enter a value";
                              }
                              return null;
                            },
                            controller: _value,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(40, 124, 77, 255),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              hintText: 'value',
                              labelText: 'value',
                              contentPadding: EdgeInsets.all(6),
                            ),
                          ),
                        ),
                        const Text("your record type"),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  const Text("Diabetes",),
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
                                const Text("pressure"),
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
                }, child: Text("save"))
              ],
            ),
          );
        },
      ),
      body: StreamBuilder(
          stream: _usersStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            late final Map<String, dynamic> userData;
            try {
              userData = snapshot.data!.data() as Map<String, dynamic>;
            } catch (e) {
              userData = {};
            }

            return userData.isEmpty
                ? const Center(
                    child: Text("No records is set yet"),
                  )
                : ListView.builder(
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      final mapKey = userData.keys.elementAt(index);
                      final mapValue = userData[mapKey] as Map<String, dynamic>;
                      return Card(
                        child: ListTile(
                          subtitle: Text("date time: ${mapValue["time"].toDate()}"),
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
