import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/widgets/snackbar/show_snackbar.dart';

Future<dynamic> settingsItemDialogDelay(
    BuildContext context,
    TextEditingController textController,
    Function dialogOnPressed,
    TextInputType inputType) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Styles.globalRadius),
          ),
          title: const Text("Opóźnienie wysyłania poleceń"),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                Flexible(
                  flex: 1,
                  child: TextField(
                    //maxLength: 5,
                    controller: textController,
                    onSubmitted: (value) {
                      // onSubmit(value);
                    },
                    keyboardType: inputType,
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
                            borderSide:
                                BorderSide(color: Styles.surfaceColor))),
                    // autofocus: true,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    autocorrect: false,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Flexible(
                  flex: 1,
                  child: Text("ms"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Styles.primaryColor),
              child: const Text('Zapisz'),
              onPressed: () {
                showSnackBar(context, dialogOnPressed(textController.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
