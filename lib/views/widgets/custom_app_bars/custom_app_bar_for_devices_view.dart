import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

class CustomAppBarForDevicesView extends StatelessWidget
    implements PreferredSizeWidget {
  CustomAppBarForDevicesView({
    super.key,
    this.height = kToolbarHeight,
  });

  final double height;
  //final TextEditingController nameTextController = TextEditingController();
  final TextEditingController ipTextController = TextEditingController();

  final PreferredSizeWidget preferredSizeWidget = PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: Container(),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return AppBar(
        title: Text('Urządzenia (${viewModel.devicesCount})',
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            )),
        backgroundColor: Colors.white24,
        elevation: 0,
        //leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_rounded),
            color: Colors.black,
            iconSize: 40,
            onPressed: () {
              showDialog(
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
                            const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10)),
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
                                      borderSide: BorderSide(
                                          color: Styles.surfaceColor)),
                                  labelText: ' IP ',
                                  labelStyle:
                                      TextStyle(color: Styles.primaryColor)),
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
                          child: const Text('Dodaj'),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(await viewModel
                                    .createDevice(ipTextController.text))));
                            /*  await viewModel.createDevice(ipTextController.text,
                                port: 5026); */
                            Navigator.of(context).pop();
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
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
