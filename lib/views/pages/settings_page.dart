import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: Center(
          child: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'do zrobienia',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
