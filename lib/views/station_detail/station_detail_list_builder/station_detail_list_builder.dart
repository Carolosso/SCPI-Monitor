import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_items/generator/station_detail_generator.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_items/multimeter/station_detail_multimeter.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_items/oscilloscope/station_detail_oscilloscope.dart';
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
                  debugPrint(viewModel
                      .stations[indexStation].devices[indexDevice].type);
                  if (viewModel
                          .stations[indexStation].devices[indexDevice].type ==
                      "Multimetr") {
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
                          showSnackBar(context, 'Usunięto urządzenie.');
                        },
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.shade300,
                            borderRadius:
                                BorderRadius.circular(Styles.globalRadius),
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.shade700,
                          ),
                        ),
                        child: StationDetailItemMultimeter(
                            viewModel: viewModel,
                            indexStation: indexStation,
                            indexDevice: indexDevice));
                  } else if (viewModel
                          .stations[indexStation].devices[indexDevice].type ==
                      "Generator") {
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
                          showSnackBar(context, 'Usunięto urządzenie.');
                        },
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.shade300,
                            borderRadius:
                                BorderRadius.circular(Styles.globalRadius),
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.shade700,
                          ),
                        ),
                        child: StationDetailItemGenerator(
                            viewModel: viewModel,
                            indexStation: indexStation,
                            indexDevice: indexDevice,
                            nameTextController: nameTextController));
                  } else if (viewModel
                          .stations[indexStation].devices[indexDevice].type ==
                      "Oscyloskop") {
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
                          showSnackBar(context, 'Usunięto urządzenie.');
                        },
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.shade300,
                            borderRadius:
                                BorderRadius.circular(Styles.globalRadius),
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.shade700,
                          ),
                        ),
                        child: StationDetailItemOscilloscope(
                            viewModel: viewModel,
                            indexStation: indexStation,
                            indexDevice: indexDevice,
                            nameTextController: nameTextController));
                  } else {
                    return Container(
                      key: UniqueKey(),
                    );
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
