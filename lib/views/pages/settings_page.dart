import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/custom_app_bar_old.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Ustawienia', 'Dodaj urządzenie', context,
          AppViewModel(), () {}, () {}),
      body: const Center(
        child: Text('Settings'),
      ),
    );
  }
}
