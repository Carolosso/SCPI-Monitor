import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

class StationDeviceItem extends StatelessWidget {
  const StationDeviceItem({
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
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Styles.surfaceColor,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              //alignment: Alignment.centerLeft,
              flex: 1,
              child: Text(
                viewModel.stations[indexStation].devices[indexDevice].name,
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
  }
}
