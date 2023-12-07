import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/widgets/snackbar/show_snackbar.dart';

final TextEditingController ipTextController = TextEditingController();
final TextEditingController portTextController = TextEditingController();

Future<dynamic> devicesAppBarDialog2(
    BuildContext context, AppViewModel viewModel) {
  NavigatorState navigator1 = Navigator.of(context);
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Styles.globalRadius),
          ),
          title: const Text('Dodaj urządzenie'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                TextField(
                  controller: ipTextController,
                  onSubmitted: (value) {
                    // onSubmit(value);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Styles.globalRadius),
                      ),
                      contentPadding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      filled: true,
                      //fillColor: viewModel.clrlvl2,
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Styles.globalRadius),
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
                const SizedBox(height: 10),
                TextField(
                  controller: portTextController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) {
                    // onSubmit(value);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Styles.globalRadius),
                      ),
                      contentPadding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      filled: true,
                      //fillColor: viewModel.clrlvl2,
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Styles.globalRadius),
                          borderSide: BorderSide(color: Styles.surfaceColor)),
                      labelText: ' Port ',
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
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Styles.primaryColor),
              child: const Text('Dodaj'),
              onPressed: () async {
                if (ipTextController.text.isNotEmpty &&
                    portTextController.text.isNotEmpty) {
                  NavigatorState navigator2 = Navigator.of(context);
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
                  showSnackBar(
                      context,
                      await viewModel.createDevice(ipTextController.text,
                          int.parse(portTextController.text)));
                  /* await viewModel.createDevice(
                    ipTextController.text, 5026); */
                  navigator1.pop();
                  navigator2.pop();
                }
              },
            ),
          ],
        );
      });
}
