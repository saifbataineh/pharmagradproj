import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:grad_test_1/ApplicationPages/Category/pop_restric.dart';
import 'package:grad_test_1/generated/l10n.dart';
import 'package:grad_test_1/sign-in-up-page/authScreen/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, this.currentLocale,this.onLanguageChange});
  final Locale? currentLocale;
  final Function(Locale)? onLanguageChange;
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool _obscureText = true;
  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).SignUpPage,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SafeArea(child: Image.asset("assets/Suboxone_Treatment.png")),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              child: TextFormField(
                //name text form field
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(40, 124, 77, 255),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: S.of(context).yournamesu,
                    labelText: S.of(context).name,
                    prefixIcon: const Icon(Icons.person)),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4) {
                    return S.of(context).shortName;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              child: TextFormField(
                //email text form field sign up
                controller: _email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(40, 124, 77, 255),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: 'abc@example.com',
                    labelText: S.of(context).email,
                    prefixIcon: const Icon(Icons.email_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return S.of(context).emailError;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              child: TextFormField(
                // password sign up text form field
                controller: _pass,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(40, 124, 77, 255),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: S.of(context).pass,
                    suffixIcon: //show password toggle
                        IconButton(
                            onPressed: _toggleVisibility,
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off)),
                    prefixIcon: const Icon(Icons.password_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5) {
                    return S.of(context).plspass;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              child: TextFormField(
                //confirm password text form field sign up
                obscureText: !_obscureText,
                controller: _confirmPass,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    filled: true,
                    suffixIcon: //show password toggle
                        IconButton(
                            onPressed: _toggleVisibility,
                            icon: Icon(!_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off)),
                    fillColor: const Color.fromARGB(40, 124, 77, 255),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: S.of(context).confirmPass,
                    prefixIcon: const Icon(Icons.password)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).doublecheckpass;
                  }
                  if (value != _pass.text) {
                    return S.of(context).doesmatch;
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
                child: Text(S.of(context).SignUp),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final message = await AuthService().registration(
                      email: _email.text,
                      password: _pass.text,
                    );
                    if (message!.contains('Success')) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(_email.text)
                          .set({});
                      if (!context.mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => PopRestrict(currentLocale: widget.currentLocale,onLanguageChange: widget.onLanguageChange,)),
                          (route) => false);
                    }
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          message=='Success'?S.of(context).suc:
                          message ==
                                "The password provided is too weak."
                            ? S.of(context).weakPass
                            : message ==
                                    "The account already exists for that email."
                                ? S.of(context).alreadyInUse
                                : S.of(context).error),
                      ),
                    );
                  }
                }),
          ]),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  final Locale? currentLocale;
  final Function(Locale)? onLanguageChange;
  const SignInForm({super.key , this.currentLocale, this.onLanguageChange});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          S.of(context).SignInPage,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SafeArea(child: Image.asset("assets/Suboxone_Treatment.png")),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              child: TextFormField(
                controller: _email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    //sign in email
                    filled: true,
                    fillColor: const Color.fromARGB(40, 124, 77, 255),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: 'abc@example.com',
                    labelText: S.of(context).email,
                    prefixIcon: const Icon(Icons.email_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return S.of(context).emailError;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              child: TextFormField(
                //sign in password
                controller: _pass,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    suffixIcon: //show password toggle
                        IconButton(
                            onPressed: _toggleVisibility,
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off)),
                    filled: true,
                    fillColor: const Color.fromARGB(40, 124, 77, 255),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: S.of(context).pass,
                    prefixIcon: const Icon(Icons.password_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5) {
                    return S.of(context).plspass;
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final message = await AuthService().login(
                  email: _email.text,
                  password: _pass.text,
                );
                if (message!.contains('Success')) {
                  if (!context.mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) =>  PopRestrict(currentLocale: widget.currentLocale,onLanguageChange: widget.onLanguageChange),
                      ),
                      (Route<dynamic> route) => false);
                }
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message=='Success'?S.of(context).suc: S.of(context).error2),
                  ),
                );
              },
              child:  Text(S.of(context).login),
            ),
          ]),
        ),
      ),
    );
  }
}
