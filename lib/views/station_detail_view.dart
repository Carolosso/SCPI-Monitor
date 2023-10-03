import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/widgets/floating_action_button_view.dart';

class StationDetailPage extends StatelessWidget {
  const StationDetailPage({super.key, required this.stationIndex});

  final int stationIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          //TODO
          // CENTER THIS SOMEHOW!
          child: AppBar(
            clipBehavior: Clip.none,
            foregroundColor: Colors.black,
            title: Column(
              children: [
                TextField(
                  onSubmitted: (value) {
                    viewModel.setStationName(stationIndex, value);
                  },
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  autocorrect: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 5),
                    hintText: viewModel.stations[stationIndex].name,
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
            centerTitle: true,
            backgroundColor: Styles.backgroundColor,
            elevation: 0,
          ),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.stations[stationIndex].devices.length, //
          itemBuilder: (context, indexDevice) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                viewModel.removeDeviceFromStation(stationIndex, indexDevice);
              },
              //TODO PROBLEM Z BACKGROUNDEM
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Styles.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        viewModel.stations[stationIndex].devices[indexDevice]
                            .name, //
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.white), //??????
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Wartość mierzona',
                          style: TextStyle(
                              fontSize: 8, color: Styles.surfaceColor),
                        ),
                      ),
                      Text(
                        '${viewModel.stations[stationIndex].devices[indexDevice].value.toStringAsFixed(3)} V', //
                        style: const TextStyle(
                            fontSize: 32,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: const FloatingActionButtonView(),
      );
    });
  }
}
