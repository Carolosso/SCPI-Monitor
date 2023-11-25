import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_item/station_detial_item_dialog.dart';
//import 'package:test/views/widgets/charts/chart_widget.dart';
import 'package:test/views/widgets/snackbar/show_snackbar.dart';

class StationDetailListBuilder extends StatelessWidget {
  const StationDetailListBuilder({
    super.key,
    required this.indexStation,
    required this.nameTextController,
    required this.unitTextController,
    required this.viewModel,
  });

  final int indexStation;
  final TextEditingController nameTextController;
  final TextEditingController unitTextController;
  final AppViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Theme(
      //to keep box decoration
      data: ThemeData(canvasColor: Colors.transparent),
      //Overlay to set boundaries to reorderable list view
      //https://stackoverflow.com/questions/75418523/setting-boundaries-to-reorderablelistview
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              return ReorderableListView.builder(
                buildDefaultDragHandles:
                    viewModel.stations[indexStation].devices.length <= 1
                        ? false
                        : true,
                onReorderStart: (index) {
                  HapticFeedback.mediumImpact();
                },
                onReorder: (oldIndex, newIndex) {
                  viewModel.onDeviceInStationReorder(
                      oldIndex, newIndex, indexStation);
                },
                shrinkWrap: true,
                itemCount: viewModel.stations[indexStation].devices.length, //
                itemBuilder: (context, indexDevice) {
                  return Dismissible(
                    key: ValueKey(viewModel
                        .stations[indexStation].devices[indexDevice].key),
                    direction: viewModel.isStopped
                        ? DismissDirection.endToStart
                        : DismissDirection.none,
                    onDismissed: (direction) {
                      viewModel.removeDeviceFromStation(
                          indexStation, indexDevice);
                      HapticFeedback.lightImpact(); //vibration
                      //Toast
                      showSnackBar(context, 'Usunięto urządzenie.');
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
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      viewModel.stations[indexStation]
                                          .devices[indexDevice].name, //
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white), //??????
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Wartość mierzona',
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: Styles.surfaceColor),
                                      ),
                                    ),
                                    Text(
                                      '${viewModel.getDeviceValue(indexStation, indexDevice)}${viewModel.getDeviceMeasuredUnit(indexStation, indexDevice)}',
                                      style: const TextStyle(
                                          fontSize: 32,
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    /* viewModel
                                            .stations[indexStation]
                                            .devices[indexDevice]
                                            .stationDetailsChartViewSelected
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Wykres',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Styles.surfaceColor),
                                            ),
                                          )
                                        : Container(),
                                    viewModel
                                            .stations[indexStation]
                                            .devices[indexDevice]
                                            .stationDetailsChartViewSelected
                                        ? ChartWidget(
                                            points: viewModel.stations[indexStation]
                                                .devices[indexDevice].chart.points,
                                          )
                                        : Container(), */
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 0,
                                  child: Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            nameTextController.text = viewModel
                                                .stations[indexStation]
                                                .devices[indexDevice]
                                                .name;
                                            unitTextController.text = viewModel
                                                .stations[indexStation]
                                                .devices[indexDevice]
                                                .measuredUnit;
                                            stationDetailItemDialog(
                                                context,
                                                indexDevice,
                                                viewModel,
                                                nameTextController,
                                                unitTextController,
                                                indexStation);
                                          },
                                          icon: Icon(
                                              color: Styles.surfaceColor,
                                              Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            viewModel.changeDisplayOnOff(
                                                indexStation, indexDevice);
                                          },
                                          icon: Icon(
                                              viewModel
                                                      .stations[indexStation]
                                                      .devices[indexDevice]
                                                      .displayON
                                                  ? Icons.tv_off
                                                  : Icons.tv,
                                              color: Styles.surfaceColor))
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
