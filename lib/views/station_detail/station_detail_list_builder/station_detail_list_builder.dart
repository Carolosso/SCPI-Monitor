import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_item/station_detial_item_dialog.dart';

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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: viewModel.stations[indexStation].devices.length, //
      itemBuilder: (context, indexDevice) {
        return Dismissible(
          key: UniqueKey(),
          direction: viewModel.isStopped
              ? DismissDirection.endToStart
              : DismissDirection.none,
          onDismissed: (direction) {
            viewModel.removeDeviceFromStation(indexStation, indexDevice);
            HapticFeedback.lightImpact(); //vibration

            //Toast
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Usunięto urządzenie.')));
          },
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
                nameTextController.text =
                    viewModel.stations[indexStation].devices[indexDevice].name;
                unitTextController.text = viewModel
                    .stations[indexStation].devices[indexDevice].measuredUnit;
                stationDetailItemDialog(context, indexDevice, viewModel,
                    nameTextController, unitTextController, indexStation);
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Styles.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        viewModel.stations[indexStation].devices[indexDevice]
                            .name, //
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.white), //??????
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Wartość mierzona',
                          style: TextStyle(
                              fontSize: 8, color: Styles.surfaceColor),
                        ),
                      ),
                      Text(
                        '${viewModel.getDeviceValue(indexStation, indexDevice)}${viewModel.getDeviceMeasuredUnit(indexStation, indexDevice)}',
                        style: const TextStyle(
                            fontSize: 32,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
