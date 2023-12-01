import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 96, 180, 248),
           
        
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:Scaffold(
          appBar:AppBar(backgroundColor: Colors.blue,
          title: const SafeArea(child: Text("PharmaTails")),
          ) ,
          body: Column(
            children: [
              Opacity(
                opacity: 1,
                child: Image.asset("assets/pharmacylog.avif",))
            ],

          ),
          ) );
  }
}
