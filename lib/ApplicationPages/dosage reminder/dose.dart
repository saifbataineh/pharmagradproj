import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/dosage%20reminder/ring.dart';

class Dose extends StatefulWidget {
  const Dose({super.key});

  @override
  State<Dose> createState() => _DoseState();
}

class _DoseState extends State<Dose> {
  late final Stream<DocumentSnapshot>? _usersStream;

  final _currentUserEmail = FirebaseAuth.instance.currentUser?.email;
  String? drug = "pills";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _num = TextEditingController();
  final TextEditingController _pack123 = TextEditingController();
  final TextEditingController _name = TextEditingController();
  late List<AlarmSettings> alarms;

  static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    super.initState();

    if (_currentUserEmail != null) {
      _usersStream = FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUserEmail)
          .snapshots();
      alarms = Alarm.getAlarms();
    }

    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings,_currentUserEmail),
    );
  }

  Future<void> navigateToRingScreen(
      AlarmSettings alarmSettings, String? user) async {
    user = _currentUserEmail;
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RingScreen(alarmSettings: alarmSettings, userEmail: user),
        ));
    Alarm.getAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      content: StatefulBuilder(builder: (context, setState) {
                        return ListView(shrinkWrap: true, children: [
                          Form(
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
                                    controller: _name,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(40, 124, 77, 255),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      hintText: 'your drug',
                                      labelText: 'Drug Name',
                                      contentPadding: EdgeInsets.all(6),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width /
                                          3.5,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "please enter a value";
                                          }
                                          return null;
                                        },
                                        controller: _num,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(6),
                                          filled: true,
                                          fillColor:
                                              Color.fromARGB(40, 124, 77, 255),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          hintText: 'pills number',
                                          labelText: 'packing',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width /
                                          3.5,
                                      child: TextFormField(
                                        controller: _pack123,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "please enter a value";
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(6),
                                          filled: true,
                                          fillColor:
                                              Color.fromARGB(40, 124, 77, 255),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          hintText: ' daily dose',
                                          labelText: 'dose',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Text("way of taking the medication "),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const Text("pills"),
                                        Radio(
                                            value: "pills",
                                            groupValue: drug,
                                            onChanged: (val) {
                                              setState(() {
                                                drug = val;
                                              });
                                            }),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text("syrup"),
                                        Radio(
                                            value: "syrup",
                                            groupValue: drug,
                                            onChanged: (val) {
                                              setState(() {
                                                drug = val;
                                              });
                                            }),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text("drops"),
                                        Radio(
                                            value: "drops",
                                            groupValue: drug,
                                            onChanged: (val) {
                                              setState(() {
                                                drug = val;
                                              });
                                            }),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]);
                      }),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              final id =
                                  DateTime.now().microsecondsSinceEpoch % 10000;
                              final now = DateTime.now();
                              if (_formKey.currentState!.validate()) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_currentUserEmail)
                                    .set({
                                  _name.text: {
                                    "pack": _pack123.text,
                                    "dailyDose": _num.text,
                                    "type": drug,
                                    "id": id.toString(),
                                  }
                                }, SetOptions(merge: true));
                                if (!context.mounted) return;
                                Navigator.of(context).pop();

                                // Ensure alarm triggers even in doze mode
                              }
                              Alarm.set(
                                  alarmSettings: AlarmSettings(
                                      id: id,
                                      dateTime: DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        now.hour,
                                        now.minute,
                                        0,
                                        0,
                                        0,
                                      ).add(Duration(minutes: 1)),
                                      assetAudioPath: "assets/marimba.mp3",
                                      notificationTitle:
                                          "enta 3awez esh taba $id",
                                      notificationBody: "al dawa ya kabten"));
                              // ignore: use_build_context_synchronously
                            },
                            child: const Text("save")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel")),
                      ],
                      icon: const Icon(
                        Icons.abc,
                      )));
            },
            label: const Text("Add your drug")),
        appBar: AppBar(),
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
                      child: Text("hello"),
                    )
                  : ListView.builder(
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        final mapKey = userData.keys.elementAt(index);
                        final mapValue =
                            userData[mapKey] as Map<String, dynamic>;
                        return Card(
                          child: ListTile(
                            leading: Container(
                              child: Image.asset(
                                mapValue['type'] == "syrup"
                                    ? 'assets/icons/syrup.png'
                                    : mapValue['type'] == "pills"
                                        ? 'assets/icons/medicine.png'
                                        : 'assets/icons/eye-drops.png',
                                color: Colors.white,
                              ),
                            ),
                            trailing: Text(
                              "pills left \n${mapValue['pack'].toString()}",
                              textAlign: TextAlign.center,
                            ),
                            title: Text(mapKey),
                          ),
                        );
                      });
            }));
  }
}
