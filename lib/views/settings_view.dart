import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/settings_view_model.dart';
import 'package:test/views/widgets/settings_view/settings_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
        builder: (context, settingsViewModel, child) {
      return Column(
        children: [
          SettingsItem(
            title: "Zakres skanowania adresów\nw sieci lokalnej",
            icon: Icons.network_wifi,
            settingsViewModel: settingsViewModel,
            textControllerText: settingsViewModel.ipRange,
            text: settingsViewModel.ipRange,
            dialogOnPressed: settingsViewModel.setNewIpRange,
          ),
          SettingsItem(
              title: "Częstotliwość wysyłania polecenia",
              icon: Icons.refresh,
              settingsViewModel: settingsViewModel,
              textControllerText: settingsViewModel.timeout.toString(),
              text: "${settingsViewModel.timeout} ms",
              dialogOnPressed: settingsViewModel.setNewTimeout),
        ],
      );
    });
  }
}
