import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:test/views/settings_view.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ustawienia',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              )),
          backgroundColor: Colors.white24,
          elevation: 0,
        ),
        //return Consumer<AppViewModel>(builder: (context, viewModel, child) {
        body: const SettingsView());
  }
}
