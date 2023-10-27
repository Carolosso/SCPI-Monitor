import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/settings/settings_items/about/settings_item_about_dialog.dart';

class SettingsItemAbout extends StatelessWidget {
  const SettingsItemAbout({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                settingsItemDialogAbout(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      icon,
                      size: 45,
                      color: Styles.surfaceColor,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 20, color: Styles.primaryColor),
                          //softWrap: true,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
