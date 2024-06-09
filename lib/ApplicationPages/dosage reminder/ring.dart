import 'package:alarm/alarm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/generated/l10n.dart';

class RingScreen extends StatefulWidget {
  final AlarmSettings alarmSettings;
  final String? userEmail;
  const RingScreen(
      {super.key, required this.alarmSettings, required this.userEmail});

  @override
  State<RingScreen> createState() => _RingScreenState();
}

class _RingScreenState extends State<RingScreen> {
  Map<String, dynamic> valuewanted = {};
  getData() async {
    DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userEmail)
        .get();
    Map<String, dynamic> data = querySnapshot.data() as Map<String, dynamic>;
    data.forEach((key, value) {
      if (value['id'] == widget.alarmSettings.id.toString()) {
        valuewanted = {key: value};
      }
    });
  }

  @override
  void initState() {
    print(widget.alarmSettings.id);
    if (widget.alarmSettings.id != 1) {
      getData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          children: [
            ElevatedButton(
                onPressed: () async {
                  print("hello world!");
                  late int pp;
                  late final String key;
                  dynamic wantedvalue;
                  if (widget.alarmSettings.id != 1) {
                    key = valuewanted.keys.first;

                    wantedvalue = valuewanted[key];
                    pp = int.parse(wantedvalue['perDose']);
                  }

                  if (widget.alarmSettings.id == 1) {
                    
                    Alarm.stop(1).then((_) => Navigator.pop(context));
                  } else if (int.parse(wantedvalue['pack']) <= pp) {
                   
                    Alarm.stop(widget.alarmSettings.id)
                        .then((_) => Navigator.pop(context));
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.userEmail)
                        .update({key: FieldValue.delete()});
                  } else {
                    
                    var wv = int.parse(wantedvalue['pack']);

                    wv = wv - pp;
                    final now = DateTime.now();
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.userEmail)
                        .set({
                      valuewanted.keys.first: {"pack": wv.toString()}
                    }, SetOptions(merge: true));
                    Alarm.set(
                            alarmSettings: widget.alarmSettings.copyWith(
                                dateTime: DateTime(now.year, now.month, now.day,
                                        now.hour, now.minute, 0, 0, 0)
                                    .add(Duration(
                                        minutes: wantedvalue['hours']))))
                        .then((value) => Navigator.pop(context));
                  }
                },
                child: Text(S.of(context).Done)),
            ElevatedButton(
                onPressed: () {
                  final now = DateTime.now();
                  Alarm.set(
                          alarmSettings: widget.alarmSettings.copyWith(
                              dateTime: DateTime(now.year, now.month, now.day,
                                      now.hour, now.minute, 0, 0, 0)
                                  .add(const Duration(minutes: 5))))
                      .then((value) => Navigator.pop(context));
                },
                child: Text(S.of(context).snooze))
          ],
        ),
      ),
    );
  }
}
