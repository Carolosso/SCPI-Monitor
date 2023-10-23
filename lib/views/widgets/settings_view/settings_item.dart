import 'package:flutter/material.dart';
import 'package:test/providers/settings_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/widgets/settings_view/settings_item_dialog.dart';

class SettingsItem extends StatelessWidget {
  SettingsItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.settingsViewModel,
      required this.textControllerText,
      required this.text,
      required this.dialogOnPressed,
      required this.textInputType});

  final SettingsViewModel settingsViewModel;
  final String title;
  final String textControllerText;
  final String text;
  final IconData icon;
  final TextEditingController textController = TextEditingController();
  final Function dialogOnPressed;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                textController.text = textControllerText;
                settingsItemDialog(
                    context, textController, dialogOnPressed, textInputType);
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
                        Text(text,
                            style: TextStyle(
                                fontSize: 16, color: Styles.primaryColor)),
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
