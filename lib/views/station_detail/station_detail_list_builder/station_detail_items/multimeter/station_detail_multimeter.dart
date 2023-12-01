import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_items/multimeter/station_detail_multimeter_dialog.dart';

class StationDetailItemMultimeter extends StatelessWidget {
  const StationDetailItemMultimeter({
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
    TextEditingController nameTextController = TextEditingController();

    TextEditingController unitTextController = TextEditingController();
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Styles.globalRadius),
        ),
        color: Styles.primaryColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    viewModel
                        .stations[indexStation].devices[indexDevice].name, //
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.white), //??????
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Wartość mierzona',
                      style: TextStyle(fontSize: 8, color: Styles.surfaceColor),
                    ),
                  ),
                  Text(
                    '${viewModel.getMultimeterValue(indexStation, indexDevice)}${viewModel.getDeviceMeasuredUnit(indexStation, indexDevice)}',
                    style: const TextStyle(
                        fontSize: 32,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              height: 40,
              right: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Styles.surfaceColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Styles.globalRadius),
                      bottomLeft: Radius.circular(Styles.globalRadius),
                    )),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          nameTextController.text = viewModel
                              .stations[indexStation].devices[indexDevice].name;
                          unitTextController.text = viewModel
                              .stations[indexStation]
                              .devices[indexDevice]
                              .measuredUnit;
                          stationDetailMultimeterDialog(
                              context,
                              indexDevice,
                              viewModel,
                              nameTextController,
                              unitTextController,
                              indexStation);
                        },
                        icon: Icon(
                          color: Styles.primaryColor,
                          Icons.edit,
                          size: 20,
                        )),
                    IconButton(
                        onPressed: () {
                          viewModel.changeDisplayOnOff(
                              indexStation, indexDevice);
                        },
                        icon: Icon(
                            viewModel.stations[indexStation]
                                    .devices[indexDevice].displayON
                                ? Icons.tv_off
                                : Icons.tv,
                            size: 20,
                            color: Styles.primaryColor))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
