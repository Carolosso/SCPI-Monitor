import 'package:flutter/material.dart';
import 'package:test/providers/settings_view_model.dart';
import 'package:test/style/theme.dart';

class SettingsItem extends StatelessWidget {
  SettingsItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.settingsViewModel,
      required this.textControllerText,
      required this.text,
      required this.dialogOnPressed});

  final SettingsViewModel settingsViewModel;
  final String title;
  final String textControllerText;
  final String text;
  final IconData icon;
  final TextEditingController textController = TextEditingController();
  final Function dialogOnPressed;
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
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        //title: const Text('Dodaj urządzenie'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Padding(
                                  padding:
                                      EdgeInsets.only(top: 10, bottom: 10)),
                              TextField(
                                controller: textController,
                                onSubmitted: (value) {
                                  // onSubmit(value);
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    filled: true,
                                    //fillColor: viewModel.clrlvl2,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Styles.surfaceColor))),
                                // autofocus: true,
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                autocorrect: false,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Styles.primaryColor),
                            child: const Text('Zapisz'),
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text(dialogOnPressed(textController.text)),
                                backgroundColor: Styles.primaryColor,
                              ));
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
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
