import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBarDebugView extends StatelessWidget
    implements PreferredSizeWidget {
  CustomAppBarDebugView({
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
    return AppBar(
      title: Text('Debug',
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          )),
      backgroundColor: Colors.white,
      elevation: 0,
      //leading: const BackButton(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
