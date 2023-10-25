import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/station_detail/station_detail_view.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item/station_item_grid_builder.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item/station_item_empty.dart';

class StationsListBuilder extends StatelessWidget {
  const StationsListBuilder({
    super.key,
    required this.viewModel,
  });

  final AppViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      itemCount: viewModel.stationsCount,
      onReorderStart: (index) {
        HapticFeedback.mediumImpact();
      },
      onReorder: (oldIndex, newIndex) {
        viewModel.onStationReorder(oldIndex, newIndex);
      },
      itemBuilder: (context, indexStation) {
        return GestureDetector(
          key: ValueKey(viewModel.stations[indexStation].key),
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
        );
      },
    );
  }
}