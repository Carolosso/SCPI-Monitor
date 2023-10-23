import 'package:flutter/material.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sadasd"),
      ),
      body: MaterialApp(
        home: Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Zamknij"),
          ),
        ),
      ),
    );
  }
}
