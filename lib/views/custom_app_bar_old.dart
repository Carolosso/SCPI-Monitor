import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/providers/app_view_model.dart';

AppBar buildAppBar(String title, String dialogTitle, BuildContext context,
    AppViewModel viewModel, Function onSubmit, Function actionAction) {
  final TextEditingController controller1 = TextEditingController();

  return AppBar(
    title: Text(title,
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
        )),
    backgroundColor: Colors.white24,
    elevation: 0,
    //leading: const BackButton(color: Colors.black),
    actions: [
      IconButton(
        icon: const Icon(Icons.add_circle_rounded),
        color: Colors.black,
        iconSize: 40,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(dialogTitle),
                  content: SingleChildScrollView(
                    child: TextField(
                      controller: controller1,
                      onSubmitted: (value) {
                        onSubmit(value);
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          filled: true,
                          //fillColor: viewModel.clrlvl2,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none)),
                      autofocus: true,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      autocorrect: false,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Uzupełnij'),
                      onPressed: () {
                        actionAction();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
      )
    ],
  );
}
