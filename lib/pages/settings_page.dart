import 'package:flutter/material.dart';

import 'package:test/views/settings/settings_view.dart';
import 'package:test/views/widgets/custom_app_bars/settings_app_bar/custom_app_bar_for_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarForSettingsView(),
        //return Consumer<AppViewModel>(builder: (context, viewModel, child) {
        body: const SettingsView());
  }
}
