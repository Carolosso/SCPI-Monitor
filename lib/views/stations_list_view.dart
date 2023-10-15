import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/station_detail_view.dart';
import 'package:test/views/widgets/custom_app_bars/custom_app_bar_for_stations_view.dart';
import 'package:test/views/widgets/floating_action_button_view.dart';

class StationsListView extends StatelessWidget {
  const StationsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: CustomAppBarForStationsView(),
        body: SafeArea(
          //TODO https://stackoverflow.com/questions/51119795/how-to-remove-scroll-glow
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: viewModel.stationsCount,
            itemBuilder: (context, indexStation) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StationDetailPage(stationIndex: indexStation),
                        ));
                  },
                  child: viewModel.stations[indexStation].devices.isEmpty
                      ? Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: Styles.primaryColor,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5),
                              child: Column(
                                children: [
                                  Text(
                                    viewModel.getStationName(indexStation),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Text(
                                      'Dodaj urządzenie w zakładce "Urządzenia"',
                                      style: TextStyle(
                                        color: Styles.surfaceColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              )))
                      //if not empty show styled Card
                      : Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: Styles.primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  viewModel.getStationName(indexStation),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 1 / .4,
                                          crossAxisSpacing: 2,
                                          mainAxisSpacing: 2),
                                  itemCount: viewModel
                                      .getStationsDevicesCount(indexStation),
                                  itemBuilder: (context, indexDevice) {
                                    return Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      color: Styles.surfaceColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              //alignment: Alignment.centerLeft,
                                              flex: 1,
                                              child: Text(
                                                viewModel.stations[indexStation]
                                                    .devices[indexDevice].name,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              //alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${viewModel.getDeviceValue(indexStation, indexDevice)}${viewModel.getDeviceMeasuredUnit(indexStation, indexDevice)}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: const FloatingActionButtonView(),
      );
    });
  }
}
