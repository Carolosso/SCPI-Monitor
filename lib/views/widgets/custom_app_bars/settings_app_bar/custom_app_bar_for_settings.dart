import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

class CustomAppBarForSettingsView extends StatelessWidget
    implements PreferredSizeWidget {
  CustomAppBarForSettingsView({
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
        title: Text('Ustawienia',
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
            icon: const Icon(Icons.wifi_find),
            color: Colors.black,
            iconSize: 40,
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) => Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Styles.surfaceColor,
                          color: Styles.primaryColor,
                        ),
                      ));
              await viewModel.getNetworkInfo();
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
