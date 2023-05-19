import 'package:flutter/material.dart';
import 'package:lab6/screens/authenticate/register.dart';
import 'package:lab6/screens/authenticate/sign_in.dart';
import 'package:lab6/services/auth.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../home/home.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else
      return Register(toggleView: toggleView);
  }
}
