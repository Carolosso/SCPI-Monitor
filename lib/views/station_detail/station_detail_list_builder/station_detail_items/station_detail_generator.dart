import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_items/station_detial_item_dialog.dart';

class StationDetailItemGenerator extends StatelessWidget {
  const StationDetailItemGenerator({
    super.key,
    required this.viewModel,
    required this.indexStation,
    required this.nameTextController,
    required this.unitTextController,
    required this.indexDevice,
  });

  final AppViewModel viewModel;
  final int indexStation;
  final int indexDevice;
  final TextEditingController nameTextController;
  final TextEditingController unitTextController;

  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    'asdasdasdasd',
                    style: TextStyle(
                        fontSize: 32,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Styles.surfaceColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Styles.globalRadius),
                        bottomRight: Radius.circular(Styles.globalRadius))),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          nameTextController.text = viewModel
                              .stations[indexStation].devices[indexDevice].name;
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
                        icon: Icon(color: Styles.primaryColor, Icons.edit)),
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
