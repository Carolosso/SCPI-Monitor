import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';

class CustomAppBarForStationsView extends StatelessWidget
    implements PreferredSizeWidget {
  CustomAppBarForStationsView({
    super.key,
    this.height = kToolbarHeight,
  });

  final double height;
  final TextEditingController nameTextController = TextEditingController();

  final PreferredSizeWidget preferredSizeWidget = PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: Container(),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return AppBar(
        title: Text('Stanowiska',
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
                      title: const Text('Dodaj stanowisko'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              controller: nameTextController,
                              onSubmitted: (value) {
                                viewModel.createStation(value);
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  bottom: 5,
                                ),
                                filled: true,
                                //fillColor: viewModel.clrlvl2,
                                border: OutlineInputBorder(),
                                labelText: ' Nazwa ',
                              ),
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
                          child: const Text('Zamknij'),
                          onPressed: () {
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
