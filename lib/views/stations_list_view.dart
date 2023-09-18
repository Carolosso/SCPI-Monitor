import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/pages/station_detail_page.dart';
import 'package:test/views/widgets/custom_app_bar.dart';
import 'package:test/views/widgets/floating_action_button_view.dart';

class StationsListView extends StatelessWidget {
  const StationsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Stanowiska',
          dialogTitle: 'Dodaj stanowisko',
          viewModel: viewModel,
          showAction: true,
          showLeading: false,
          onActionTap: viewModel.fillLists,
          onSubmit: viewModel.createStation,
        ),
        //buildAppBar('Widok stanowisk', 'Dodaj stanowisko', context,
        //  viewModel, viewModel.createStation, viewModel.fillLists),
        body: SafeArea(
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
                                      'Tap to see details',
                                      style: TextStyle(
                                        color: Colors.red.shade700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              )))
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
                                                'Device ${indexDevice + 1}',
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ), //??????
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              //alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${viewModel.getDeviceValue(indexStation, indexDevice).toStringAsFixed(3)} V',
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
