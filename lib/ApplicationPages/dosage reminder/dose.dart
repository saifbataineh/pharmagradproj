import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/dosage%20reminder/ring.dart';
import 'package:grad_test_1/generated/l10n.dart';


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
  final TextEditingController _packdaily = TextEditingController();
  bool isActive = false;

  static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    super.initState();

    if (_currentUserEmail != null) {
      _usersStream = FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUserEmail)
          .snapshots();
    }

    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings, _currentUserEmail),
    );
  }

  Future<void> navigateToRingScreen(
      AlarmSettings alarmSettings, String? user) async {
    user = _currentUserEmail;
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RingScreen(alarmSettings: alarmSettings, userEmail: user),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: isActive?Colors.transparent:const Color.fromARGB(69, 124, 77, 255),
             foregroundColor:isActive?Colors.transparent : Colors.black,
              onPressed:isActive?null: () {
                final now = DateTime.now();
                Alarm.set(
                    alarmSettings: AlarmSettings(
                        id: 1,
                        dateTime: DateTime(
                          now.year,
                          now.month,
                          now.day,
                          now.hour,
                          now.minute,
                          0,
                          0,
                          0,
                        ).add(const Duration(minutes: 1)),
                        assetAudioPath: "assets/marimba.mp3",
                        notificationTitle: S.of(context).waterR,
                        notificationBody: S.of(context).waterTitle));
                setState(() {
                  isActive = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).waterSet)));
              },
              child: const Icon(Icons.water_drop_outlined),
            ),
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton.extended(
              backgroundColor: const Color.fromARGB(69, 124, 77, 255),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          content:
                              StatefulBuilder(builder: (context, setState) {
                            return ListView(shrinkWrap: true, children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  3.5,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return S
                                                    .of(context)
                                                    .alarmMissingValue;
                                              }
                                              return null;
                                            },
                                            controller: _name,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  40, 124, 77, 255),
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30))),
                                              hintText: S.of(context).alarmName,
                                              labelText:
                                                  S.of(context).alarmName2,
                                              contentPadding:
                                                  const EdgeInsets.all(6),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  3.5,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return S
                                                    .of(context)
                                                    .alarmMissingValue;
                                              }
                                              return null;
                                            },
                                            controller: _num,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  40, 124, 77, 255),
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30))),
                                              hintText:
                                                  S.of(context).alarmPacking2,
                                              labelText:
                                                  S.of(context).alarmPacking,
                                              contentPadding:
                                                  const EdgeInsets.all(6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  3.5,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return S
                                                    .of(context)
                                                    .alarmMissingValue2;
                                              }
                                              return null;
                                            },
                                            controller: _packdaily,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(6),
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  40, 124, 77, 255),
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30))),
                                              hintText:
                                                  S.of(context).pillsPerDoseH,
                                              labelText:
                                                  S.of(context).pillsPerDose,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  3.5,
                                          child: TextFormField(
                                            controller: _pack123,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return S
                                                    .of(context)
                                                    .alarmMissingValue3;
                                              }
                                              return null;
                                            },
                                            keyboardType: const TextInputType
                                                .numberWithOptions(),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(6),
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  40, 124, 77, 255),
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30))),
                                              hintText: S.of(context).alarmDose,
                                              labelText:
                                                  S.of(context).alarmDose1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(S.of(context).alarmText),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(S.of(context).alarmPills),
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
                                            Text(S.of(context).alarmSyrup),
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
                                            Text(S.of(context).alarmDrops),
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
                                  int pillPerDay =
                                      24 ~/ int.parse(_pack123.text);
                                  final id =
                                      DateTime.now().microsecondsSinceEpoch %
                                          10000;
                                  final now = DateTime.now();
                                  if (_formKey.currentState!.validate()) {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(_currentUserEmail)
                                        .set({
                                      _name.text: {
                                        "pack": _num.text,
                                        "dailyDose": _pack123.text,
                                        "type": drug,
                                        "id": id.toString(),
                                        "hours": pillPerDay,
                                        "perDose": _packdaily.text,
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
                                          ).add(Duration(minutes: pillPerDay)),
                                          assetAudioPath: "assets/marimba.mp3",
                                          notificationTitle:
                                              "${S.of(context).remind} (${_name.text})",
                                          notificationBody:
                                              S.of(context).remind2));
                                },
                                child: Text(S.of(context).alarmSave)),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(S.of(context).alarmCancel)),
                          ],
                          icon: const Icon(
                            Icons.abc,
                          )));
                },
                label: Text(S.of(context).alarmAddbutton)),
          ],
        ),
        body: StreamBuilder(
            stream: _usersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(S.of(context).errorText);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(S.of(context).Loading);
              }
              late final Map<String, dynamic> userData;
              try {
                userData = snapshot.data!.data() as Map<String, dynamic>;
              } catch (e) {
                userData = {};
              }

              return userData.isEmpty
                  ? Center(
                      child: Text(S.of(context).alarmEmpty),
                    )
                  : ListView.builder(
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        final mapKey = userData.keys.elementAt(index);
                        final mapValue =
                            userData[mapKey] as Map<String, dynamic>;
                        return Card(
                          child: ListTile(
                            leading: Image.asset(
                              mapValue['type'] == "syrup"
                                  ? 'assets/icons/syrup.png'
                                  : mapValue['type'] == "pills"
                                      ? 'assets/icons/medicine.png'
                                      : 'assets/icons/eye-drops.png',
                              color: Colors.white,
                            ),
                            trailing: Text(
                              "${S.of(context).alarmPillsLeft} \n${mapValue['pack'].toString()}",
                              textAlign: TextAlign.center,
                            ),
                            title: Text(mapKey),
                          ),
                        );
                      });
            }));
  }
}
