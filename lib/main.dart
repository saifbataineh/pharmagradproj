import 'package:alarm/alarm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/Category/category.dart';

import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:grad_test_1/firebase_options.dart';

import 'package:grad_test_1/sign-in-up-page/welcome_page.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init(showDebugLogs: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (context) => TextProvider(),
      builder: (context, child) {
        return const MyApp();
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter auth',
        theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                color: Color.fromARGB(69, 124, 77, 255),
                iconTheme: IconThemeData(color: Colors.white)),
            textButtonTheme: const TextButtonThemeData(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(69, 124, 77, 255)))),
            primaryColor: Colors.white,
            scaffoldBackgroundColor: const Color.fromARGB(255, 51, 51, 51)),
        home: FirebaseAuth.instance.currentUser == null
            ? const WelcomePage()
            : CategorySelector());
  }
}
