import 'package:flutter/material.dart';

import 'package:test/views/settings/settings_view.dart';
import 'package:test/views/widgets/custom_app_bars/custom_app_bar_for_settings.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarForSettingsView(),
        //return Consumer<AppViewModel>(builder: (context, viewModel, child) {
        body: const SettingsView());
  }
}
