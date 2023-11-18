import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/station_detail/station_detail_view.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item/station_item_grid_builder.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item/station_item_empty.dart';
import 'package:test/views/widgets/snackbar/show_snackbar.dart';

class StationsListBuilder extends StatelessWidget {
  const StationsListBuilder({
    super.key,
    required this.viewModel,
  });

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
          OverlayEntry(builder: (context) {
            return ReorderableListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              //prevent to move while one item
              buildDefaultDragHandles:
                  (viewModel.stationsCount <= 1 || !viewModel.isStopped)
                      ? false
                      : true,
              shrinkWrap: true,
              itemCount: viewModel.stationsCount,
              onReorderStart: (index) {
                HapticFeedback.mediumImpact();
              },
              onReorder: (oldIndex, newIndex) {
                viewModel.onStationReorder(oldIndex, newIndex);
              },
              itemBuilder: (context, indexStation) {
                return Dismissible(
                  key: ValueKey(viewModel.stations[indexStation].key),
                  onDismissed: (direction) {
                    showSnackBar(context,
                        "Usunięto stanowisko: ${viewModel.getStationName(indexStation)}");
                    viewModel.removeStation(indexStation);
                  },
                  direction: viewModel.isStopped
                      ? DismissDirection.endToStart
                      : DismissDirection.none,
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StationDetailPage(indexStation: indexStation),
                            ));
                      },
                      child: viewModel.stations[indexStation].devices.isEmpty
                          ? StationItemEmpty(
                              viewModel: viewModel,
                              indexStation: indexStation,
                            )
                          //if not empty show styled Card
                          : StationItemGridBuilder(
                              viewModel: viewModel, indexStation: indexStation),
                    ),
                  ),
                );
              },
            );
          })
        ],
      ),
    );
  }
}
