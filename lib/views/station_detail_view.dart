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
          child: AppBar(
            clipBehavior: Clip.none,
            foregroundColor: Colors.black,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onSubmitted: (value) {
                    viewModel.setStationName(stationIndex, value);
                  },
                  // textAlign: TextAlign.start,
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
            //centerTitle: true,
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
              direction: viewModel.isStopped
                  ? DismissDirection.endToStart
                  : DismissDirection.none,
              onDismissed: (direction) {
                viewModel.removeDeviceFromStation(stationIndex, indexDevice);
                //Toast
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usunięto urządzenie.')));
              },
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.red.shade700,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
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
                          '${viewModel.getDeviceValue(stationIndex, indexDevice)}${viewModel.getDeviceMeasuredUnit(stationIndex, indexDevice)}',
                          style: const TextStyle(
                              fontSize: 32,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
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
