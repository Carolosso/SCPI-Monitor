import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

final TextEditingController nameTextController = TextEditingController();

Future<dynamic> stationsAppBarDialog(
    BuildContext context, AppViewModel viewModel) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dodaj stanowisko'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameTextController,
                  onSubmitted: (value) {
                    viewModel.createStation(value);
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
                          borderSide: BorderSide(color: Styles.surfaceColor)),
                      labelText: ' Nazwa ',
                      labelStyle: TextStyle(color: Styles.primaryColor)),
                  autofocus: true,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  autocorrect: false,
                  style: TextStyle(
                    color: Styles.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                  cursorColor: Styles.primaryColor,
                ),
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