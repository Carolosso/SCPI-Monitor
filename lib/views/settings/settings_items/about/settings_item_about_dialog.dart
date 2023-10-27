import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';

Future<dynamic> settingsItemDialogAbout(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //title: const Text('Dodaj urządzenie'),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Styles.primaryColor),
              child: const Text('Zamknij'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
