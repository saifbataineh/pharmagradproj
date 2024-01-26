import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/Category/category.dart';
import 'package:grad_test_1/sign-in-up-page/authScreen/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
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
        title: const Text(
          'SignUp Page',
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
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(40, 124, 77, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: 'your name',
                    labelText: 'name',
                    prefixIcon: Icon(Icons.person)),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4) {
                    return 'your name must be 4 charachters at least';
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
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(40, 124, 77, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: 'abc@example.com',
                    labelText: 'email',
                    prefixIcon: Icon(Icons.email_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'please enter correct email';
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
                    labelText: 'password',
                    suffixIcon: //show password toggle
                        IconButton(
                            onPressed: _toggleVisibility,
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off)),
                    prefixIcon: const Icon(Icons.password_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5) {
                    return 'please enter your password';
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
                    labelText: 'confirmed password ',
                    prefixIcon: const Icon(Icons.password)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please confirm your password';
                  }
                  if (value != _pass.text) {
                    return 'password doesn\'t match';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
                child: const Text('Sign up '),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final message = await AuthService().registration(
                      email: _email.text,
                      password: _pass.text,
                    );
                    if (message!.contains('Success')) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(_email.text).set({});
                      if (!context.mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => CategorySelector()),
                          (route) => false);
                    }
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
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
  const SignInForm({super.key});

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
        title: const Text(
          'SignIn Page',
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
                controller: _email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    //sign in email
                    filled: true,
                    fillColor: Color.fromARGB(40, 124, 77, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: 'abc@example.com',
                    labelText: 'email',
                    prefixIcon: Icon(Icons.email_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'please enter your email';
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
                    labelText: 'password',
                    prefixIcon: const Icon(Icons.password_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5) {
                    return 'please enter your password';
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
                        builder: (context) => CategorySelector(),
                      ),
                      (Route<dynamic> route) => false);
                }
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
              child: const Text('Login'),
            ),
          ]),
        ),
      ),
    );
  }
}
