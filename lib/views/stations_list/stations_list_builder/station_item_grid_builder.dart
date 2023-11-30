import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item_generator/station_device_generator_item.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item_multimeter/station_device_multimeter_item.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item_oscilloscope/station_device_oscilloscope_item.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item_power_supply/station_device_power_supply_item.dart';

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
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Styles.globalRadius),
      ),
      color: Styles.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              viewModel.getStationName(indexStation),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            ListView.builder(
                itemCount: viewModel.stations[indexStation].devices.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                //TODO SCROLLOWANIE URZADZEN W STANOWISKU???
                itemBuilder: (context, indexDevice) {
                  switch (viewModel
                      .stations[indexStation].devices[indexDevice].type) {
                    case "Multimetr":
                      return StationDeviceItemMultimeter(
                        viewModel: viewModel,
                        indexStation: indexStation,
                        indexDevice: indexDevice,
                      );
                    case "Generator":
                      return StationDeviceItemGenerator(
                        viewModel: viewModel,
                        indexStation: indexStation,
                        indexDevice: indexDevice,
                      );
                    case "Oscyloskop":
                      return StationDeviceItemOscilloscope(
                        viewModel: viewModel,
                        indexStation: indexStation,
                        indexDevice: indexDevice,
                      );
                    case "Zasilacz":
                      return StationDeviceItemPowerSupply(
                        viewModel: viewModel,
                        indexStation: indexStation,
                        indexDevice: indexDevice,
                      );
                    default:
                      return Container(height: 0);
                  }
                })
          ],
        ),
      ),
    );
  }
}
