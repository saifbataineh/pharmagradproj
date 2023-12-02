import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  SignInForm({super.key});
  @override
  State<StatefulWidget> createState() {
    return _SignInFormState();
  }
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Login Page',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SafeArea(child: Image.asset("assets/Suboxone_Treatment.png")),
            Container(
              margin: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                
                decoration: const InputDecoration(filled: true,
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
              margin: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
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
