import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';

Future<dynamic> settingsItemDialogAbout(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Styles.globalRadius),
          ),
          title: const Text("O aplikacji"),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                Text(
                  "Projekt inżynierski",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                Text("Karol Bulanowski"),
                Text("Jakub Wojturski"),
                Text("v0.8.5"),
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
