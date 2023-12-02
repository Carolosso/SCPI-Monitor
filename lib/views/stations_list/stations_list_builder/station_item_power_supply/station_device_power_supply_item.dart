import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item_power_supply/power_supply_channel_builder.dart';

class StationDeviceItemPowerSupply extends StatelessWidget {
  const StationDeviceItemPowerSupply({
    super.key,
    required this.viewModel,
    required this.indexStation,
    required this.indexDevice,
  });

  final AppViewModel viewModel;
  final int indexStation;
  final int indexDevice;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Styles.globalRadius),
      ),
      color: Styles.surfaceColor,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                viewModel.stations[indexStation].devices[indexDevice].name,
                textAlign: TextAlign.left,
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                powerSupplyChannelBuilder(
                    1, viewModel, indexStation, indexDevice),
                const SizedBox(
                  width: 3,
                ),
                powerSupplyChannelBuilder(
                    2, viewModel, indexStation, indexDevice),
                const SizedBox(
                  width: 3,
                ),
                powerSupplyChannelBuilder(
                    3, viewModel, indexStation, indexDevice),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
