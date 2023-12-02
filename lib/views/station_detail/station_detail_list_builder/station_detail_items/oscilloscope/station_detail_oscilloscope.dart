import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/station_detail/station_detail_list_builder/station_detail_items/oscilloscope/station_detail_oscilloscope_dialog.dart';
import 'package:test/views/stations_list/stations_list_builder/station_item_oscilloscope/oscilloscope_channel_builder.dart';

class StationDetailItemOscilloscope extends StatelessWidget {
  const StationDetailItemOscilloscope({
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
                            oscilloscopeChannelBuilder(
                                1, viewModel, indexStation, indexDevice),
                            const SizedBox(
                              width: 3,
                            ),
                            oscilloscopeChannelBuilder(
                                2, viewModel, indexStation, indexDevice),
                            const SizedBox(
                              width: 3,
                            ),
                            oscilloscopeChannelBuilder(
                                3, viewModel, indexStation, indexDevice),
                            const SizedBox(
                              width: 3,
                            ),
                            oscilloscopeChannelBuilder(
                                4, viewModel, indexStation, indexDevice)
                          ],
                        ),
                      ],
                    ),
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
                          stationDetailOscilloscopeDialog(context, indexDevice,
                              viewModel, nameTextController, indexStation);
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
