import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/widgets/custom_app_bars/devices_list_app_bar/devices_app_bar_dialog1.dart';
import 'package:test/views/widgets/custom_app_bars/devices_list_app_bar/devices_app_bar_dialog2.dart';

class CustomAppBarForDevicesView extends StatelessWidget
    implements PreferredSizeWidget {
  CustomAppBarForDevicesView({
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
            icon: const Icon(Icons.search_rounded),
            color: Colors.black,
            iconSize: 40,
            onPressed: () async {
              devicesAppBarDialog1(context, viewModel);
              await viewModel.findDevicesInNetwork();
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_rounded),
            color: Colors.black,
            iconSize: 40,
            onPressed: () {
              devicesAppBarDialog2(context, viewModel);
            },
          )
        ],
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
