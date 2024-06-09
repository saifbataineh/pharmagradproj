import 'package:alarm/alarm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grad_test_1/ApplicationPages/Category/pop_restric.dart';
import 'package:grad_test_1/Providers/listen_provider.dart';
import 'package:grad_test_1/firebase_options.dart';
import 'package:grad_test_1/generated/l10n.dart';
import 'package:grad_test_1/sign-in-up-page/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Alarm.init(showDebugLogs: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (context) => TextProvider(),
      builder: (context, child) {
        TextProvider().fetchLocale;

        return const MyApp();
      }));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String? locale;
  late final SharedPreferences prefs;
  Locale localel = const Locale("en");

  @override
  void initState() {
    setPrefs();

    super.initState();
  }

  void setPrefs() async {
    prefs = await SharedPreferences.getInstance();
    locale = prefs.getString("language_code");

    if (locale != null) {
      setLocale(Locale(locale!),locale!);
      setState(() {});
    }
  }

  // Initial locale

  // Function to set and update locale (replace with your implementation)
  void setLocale(Locale localell,String lang) {
    setState(() {
      localel = localell;
      

      prefs.setString("language_code", lang );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: localel,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
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
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(69, 124, 77, 255)))),
            primaryColor: Colors.white,
            scaffoldBackgroundColor: const Color.fromARGB(255, 51, 51, 51)),
        home: FirebaseAuth.instance.currentUser == null
            ? WelcomePage(currentLocale: localel, onLanguageChange: setLocale)
            : PopRestrict(
                currentLocale: localel,
                onLanguageChange: setLocale,
              ));
  }
}
