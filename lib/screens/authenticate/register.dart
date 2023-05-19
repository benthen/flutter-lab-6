import 'package:flutter/material.dart';
import 'package:lab6/services/auth.dart';
import 'package:lab6/shared/constants.dart';

import '../../shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

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
            title: const Text("Sign up to Brew Crew"),
            actions: [
              ElevatedButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('Sign In'),
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
                        dynamic result = await _auth.register(email, password);
                        print(result);
                        if (result == null) {
                          setState(() {
                            error = 'Please enter a valid email';
                            loading = false;
                          });
                        } else Navigator.pushNamed(context, '/home');
                      }
                    },
                    child: const Text('Register',
                        style: TextStyle(color: Colors.white))),
                const SizedBox(height: 20),
                Text(error, style: const TextStyle(color: Colors.blue))
              ],
            ),
          ),
        ));
  }
}
