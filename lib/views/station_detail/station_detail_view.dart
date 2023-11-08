import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_list_builder.dart';
import 'package:test/views/widgets/floating_button/floating_action_button_view.dart';
import 'package:test/views/widgets/snackbar/show_snackbar.dart';

class StationDetailPage extends StatelessWidget {
  StationDetailPage({super.key, required this.indexStation});

  final int indexStation;

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController unitTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            clipBehavior: Clip.none,
            foregroundColor: Colors.black,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onSubmitted: (value) {
                    showSnackBar(
                        context, viewModel.setStationName(indexStation, value));
                  },
                  // textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  autocorrect: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 5),
                    hintText: viewModel.stations[indexStation].name,
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                const Text(
                  'Widok szczegołowy',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            //centerTitle: true,
            backgroundColor: Styles.backgroundColor,
            elevation: 0,
          ),
        ),
        body: StationDetailListBuilder(
          indexStation: indexStation,
          nameTextController: nameTextController,
          unitTextController: unitTextController,
          viewModel: viewModel,
        ),
        floatingActionButton: const FloatingActionButtonView(),
      );
    });
  }
}
