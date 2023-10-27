import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';

Future<dynamic> settingsItemDialogDelay(
    BuildContext context,
    TextEditingController textController,
    Function dialogOnPressed,
    TextInputType inputType) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //title: const Text('Dodaj urządzenie'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                TextField(
                  controller: textController,
                  onSubmitted: (value) {
                    // onSubmit(value);
                  },
                  keyboardType: inputType,
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
                          borderSide: BorderSide(color: Styles.surfaceColor))),
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
              style: TextButton.styleFrom(foregroundColor: Styles.primaryColor),
              child: const Text('Zapisz'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(dialogOnPressed(textController.text)),
                  backgroundColor: Styles.primaryColor,
                ));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
