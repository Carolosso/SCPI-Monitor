import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_items/generator/station_detail_generator_dialog.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_items/multimeter/station_detail_multimeter_dialog.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item_generator/generator_channel_builder.dart';

class StationDetailItemGenerator extends StatelessWidget {
  const StationDetailItemGenerator({
    super.key,
    required this.viewModel,
    required this.indexStation,
    required this.nameTextController,
    required this.indexDevice,
  });

  final AppViewModel viewModel;
  final int indexStation;
  final int indexDevice;
  final TextEditingController nameTextController;

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
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            generatorChannelBuilder(1),
                            const SizedBox(
                              width: 6,
                            ),
                            generatorChannelBuilder(2)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
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
                          stationDetailGeneratorDialog(context, indexDevice,
                              viewModel, nameTextController, indexStation);
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
