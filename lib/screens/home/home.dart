import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lab6/screens/home/setting_form.dart';
import 'package:lab6/services/database.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../authenticate/authenticate.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  CollectionReference users = FirebaseFirestore.instance.collection('brews');

  List data = [];
  

  void getData() async {
    dynamic result = await Database().getDocs();
    if (result == null) {
      print("No data");
    } else {
      setState(() {
        data = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    print("data");
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return Scaffold(
        backgroundColor: Colors.indigoAccent,
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          actions: [
            ElevatedButton.icon(
                onPressed: () async {
                  dynamic result = await _auth.signout();
                  if (result == null) {
                    Navigator.pushNamed(context, '/');
                    print('signed out');
                  } else
                    print('invalid');
                },
                icon: Icon(Icons.person),
                label: const Text('Logout')),
            ElevatedButton.icon(
                onPressed: _showSettingPanel,
                icon: const Icon(Icons.settings),
                label: const Text("Settings"))
          ],
        ),
        body: Container(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(data[index]['name']),
                subtitle: Text("${data[index]['sugars']} sugars"),
                leading: CircleAvatar(
                  backgroundColor: Colors.brown[data[index]['strength']],
                  radius: 25.0,
                ),
              );
            }),
          ),
        ));
  }
}
