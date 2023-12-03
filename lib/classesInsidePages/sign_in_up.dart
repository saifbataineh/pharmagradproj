import 'package:flutter/material.dart';
import 'package:grad_test_1/authScreen/auth_screen.dart';
import 'package:grad_test_1/screens/main-page.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.deepPurpleAccent,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(40, 124, 77, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: 'saif bataineh',
                    labelText: 'name',
                    prefixIcon: Icon(Icons.person)),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length > 4) {
                    return 'your name must be 4 charachters at least';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              child: TextFormField(
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
                controller: _pass,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(40, 124, 77, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'password',
                    prefixIcon: Icon(Icons.password_outlined)),
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
                obscureText: true,
                controller: _confirmPass,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(40, 124, 77, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'confirmed password ',
                    prefixIcon: Icon(Icons.password)),
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
              onPressed: () async {
             
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                     final message = await AuthService()
                    .registration(email: _email.text, password: _pass.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('signed Up successfully ')),
                   
                    
                  );
                    Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const MainPage()));
                }
              },
              child: const Text('Sign up '),
            ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.deepPurpleAccent,
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
                    return 'please enter your email';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(40, 124, 77, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'password',
                    prefixIcon: Icon(Icons.password_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5) {
                    return 'please enter your password';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Sign in '),
            ),
          ]),
        ),
      ),
    );
  }
}
