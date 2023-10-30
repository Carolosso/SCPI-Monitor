import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/settings_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/settings/settings_items/about/settings_item_about.dart';
import 'package:test/views/settings/settings_items/delay/settings_item_delay.dart';
import 'package:test/views/settings/settings_items/language/settings_item_language.dart';
import 'package:test/views/settings/settings_items/network_address/settings_item_network.dart';
import 'package:test/views/settings/settings_items/theme/settings_item_theme.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
        builder: (context, settingsViewModel, child) {
      return Column(
        children: [
          SettingsItemNetwork(
            title: "Adres sieci lokalnej",
            icon: Icons.network_wifi,
            settingsViewModel: settingsViewModel,
            text: settingsViewModel.ipRange,
          ),
          SettingsItemDelay(
            title: "Opóźnienie wysyłania poleceń",
            icon: Icons.refresh,
            settingsViewModel: settingsViewModel,
            textControllerText: settingsViewModel.timeout.toString(),
            text: "${settingsViewModel.timeout} ms",
            dialogOnPressed: settingsViewModel.setNewTimeout,
            textInputType: TextInputType.number,
          ),
          SettingsItemTheme(
            title: "Motyw aplikacji",
            icon: Icons.invert_colors,
            settingsViewModel: settingsViewModel,
            text: Styles.isDarkTheme ? "Ciemny" : "Jasny",
          ),
          SettingsItemLanguage(
            title: "Język aplikacji",
            icon: Icons.language,
            settingsViewModel: settingsViewModel,
            text: "Polski",
          ),
          const SettingsItemAbout(
            title: "O aplikacji",
            icon: Icons.info_outline_rounded,
          )
        ],
      );
    });
  }
}
