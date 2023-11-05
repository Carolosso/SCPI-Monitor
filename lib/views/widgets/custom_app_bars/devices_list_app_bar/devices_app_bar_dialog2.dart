import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/widgets/snackbar/show_snackbar.dart';

final TextEditingController ipTextController = TextEditingController();

Future<dynamic> devicesAppBarDialog2(
    BuildContext context, AppViewModel viewModel) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dodaj urządzenie'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                /*                            TextField(
                           //controller: nameTextController,
                            onSubmitted: (value) {
                              //onSubmit(value);
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                bottom: 5,
                              ),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Styles.surfaceColor)),
                              labelText: ' Nazwa ',
                            ),
                            autofocus: true,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            autocorrect: false,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ), */
                const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                TextField(
                  controller: ipTextController,
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
                          borderSide: BorderSide(color: Styles.surfaceColor)),
                      labelText: ' IP ',
                      labelStyle: TextStyle(color: Styles.primaryColor)),
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
              child: const Text('Dodaj'),
              onPressed: () async {
                NavigatorState navigator = Navigator.of(context);
                showDialog(
                    context: context,
                    builder: (context) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                backgroundColor: Styles.surfaceColor,
                                color: Styles.primaryColor,
                              ),
                            ],
                          ),
                        ));
                showSnackBar(context,
                    await viewModel.createDevice(ipTextController.text, 5025));
                // await viewModel.createDevice(ipTextController.text, 5026);
                navigator.pop();
              },
            ),
          ],
        );
      });
}
