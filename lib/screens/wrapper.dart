import 'package:flutter/material.dart';
import 'package:lab6/screens/authenticate/authenticate.dart';
import '../models/user.dart';
import '../services/auth.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    if (AuthService().signInAnon() == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
