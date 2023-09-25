import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/providers/app_view_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.title,
    required this.showAction,
    required this.showLeading,
    required this.onActionTap,
    required this.viewModel,
    required this.dialogTitle,
    required this.onSubmit,
    this.height = kToolbarHeight,
  });

  final String title;
  final bool showAction;
  final bool showLeading;
  final Function onActionTap;
  final AppViewModel viewModel;
  final String dialogTitle;
  final Function onSubmit;
  final double height;
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController ipTextController = TextEditingController();

  final PreferredSizeWidget preferredSizeWidget = PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: Container(),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          )),
      backgroundColor: Colors.white24,
      elevation: 0,
      leading: showLeading ? const BackButton() : null,
      //leading: const BackButton(color: Colors.black),
      actions: !showAction
          ? []
          : [
              IconButton(
                icon: const Icon(Icons.add_circle_rounded),
                color: Colors.black,
                iconSize: 40,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(dialogTitle),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextField(
                                  controller: nameTextController,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none)),
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.center,
                                  autocorrect: false,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextField(
                                  controller: ipTextController,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none)),
                                  autofocus: true,
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
                              child: const Text('Uzupełnij'),
                              onPressed: () {
                                onActionTap(nameTextController.text,
                                    ipTextController.text);
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

  @override
  Size get preferredSize => Size.fromHeight(height);
}
