import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item/station_device_item/station__device_item.dart';

class StationItemGridBuilder extends StatelessWidget {
  const StationItemGridBuilder({
    super.key,
    required this.viewModel,
    required this.indexStation,
  });

  final AppViewModel viewModel;
  final int indexStation;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Styles.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
          child: Column(
            children: [
              Text(
                viewModel.getStationName(indexStation),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / .4, //1/ .4
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                itemCount: viewModel.getStationsDevicesCount(indexStation),
                itemBuilder: (context, indexDevice) {
                  return StationDeviceItem(
                    viewModel: viewModel,
                    indexStation: indexStation,
                    indexDevice: indexDevice,
                  );
                },
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
