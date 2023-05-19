import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab6/screens/authenticate/authenticate.dart';
import 'package:lab6/screens/home/home.dart';
import 'package:lab6/screens/wrapper.dart';
import 'package:lab6/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Authenticate(),
      '/home': (context) => Home(),
    },
  ));
}

