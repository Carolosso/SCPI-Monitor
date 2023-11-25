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
        borderRadius: BorderRadius.circular(Styles.globalRadius),
      ),
      color: Styles.surfaceColor,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
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
              /* viewModel.stations[indexStation].devices[indexDevice]
                      .stationsChartViewSelected
                  ? Expanded(
                      flex: 3,
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Styles.globalRadius),
                        ),
                        elevation: 0,
                        color: Styles.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ChartWidget(
                            points: viewModel.stations[indexStation]
                                .devices[indexDevice].chart.points,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      flex: 0,
                      child: Container(),
                    ), */
            ],
          ),
        ),
      ),
    );
  }
}
