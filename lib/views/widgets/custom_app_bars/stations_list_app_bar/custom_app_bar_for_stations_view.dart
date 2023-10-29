import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/widgets/custom_app_bars/stations_list_app_bar/stations_app_bar_dialog.dart';

class CustomAppBarForStationsView extends StatelessWidget
    implements PreferredSizeWidget {
  CustomAppBarForStationsView({
    super.key,
    this.height = kToolbarHeight,
  });

  final double height;

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
              stationsAppBarDialog(context, viewModel);
            },
          )
        ],
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
