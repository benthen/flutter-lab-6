import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lab6/shared/constants.dart';

import '../../services/database.dart';

class SettingsForm extends StatefulWidget {
  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentName = '';
  String _currentSugars = '0';
  int _currentStrength = 500;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const Text("Update your brew", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            TextFormField(
              decoration: textInputDecoration,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please enter a name";
                }
              },
              onChanged: (val) {
                setState(() {
                  _currentName = val;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: textInputDecoration,
              value: _currentSugars,
              items: <String>['0', '1', '2', '3', '4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    "$value sugars",
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  _currentSugars = newValue!;
                });
              },
            ),
            Slider(
                value: _currentStrength.toDouble(),
                onChanged: (val) => setState(() {
                      _currentStrength = val.round();
                    }),
                min: 100.0,
                max: 900.0,
                divisions: 8,
                activeColor: Colors.red[_currentStrength],
                inactiveColor: Colors.red[_currentStrength],
                ),
            ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    await Database().update(_currentSugars, _currentName, _currentStrength);
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                  print(_currentSugars);
                  print(_currentName);
                  print(_currentStrength);
                },
                child: const Text("Update"))
          ],
        ));
  }
}
