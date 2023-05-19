import 'package:flutter/material.dart';
import 'package:lab6/services/auth.dart';
import 'package:lab6/shared/constants.dart';

import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
            backgroundColor: Colors.indigoAccent,
            elevation: 0.0,
            title: const Text("Sign in to Brew Crew"),
            actions: [
              ElevatedButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('Register'),
                onPressed: () {
                  widget.toggleView();
                },
              )
            ]),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                // email
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                const SizedBox(height: 20),
                // password
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signin(email, password);
                        print(result);
                        if (result == null) {
                          setState(() {
                            error = 'could not sign in';
                            loading = false;
                          });
                        } else Navigator.pushNamed(context, '/home');
                      }
                    },
                    child: const Text('Sign In',
                        style: TextStyle(color: Colors.white))),
                const SizedBox(height: 20),
                Text(error, style: const TextStyle(color: Colors.blue))
              ],
            ),
          ),
        ));
  }
}
