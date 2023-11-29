import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

Future<void> stationDetailMultimeterDialog(
    BuildContext context,
    int indexDevice,
    AppViewModel viewModel,
    TextEditingController nameTextController,
    TextEditingController unitTextController,
    int indexStation) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Edytuj ${viewModel.stations[indexStation].devices[indexDevice].name}'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameTextController,
                  onSubmitted: (value) {},
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Styles.primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Styles.surfaceColor)),
                    labelText: ' Nazwa ',
                  ),
                  //autofocus: true,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  autocorrect: false,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                TextField(
                  controller: unitTextController,
                  onSubmitted: (value) {},
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Styles.primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Styles.surfaceColor)),
                    labelText: ' Jednostka ',
                  ),
                  //autofocus: true,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  autocorrect: false,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                /* SizedBox(
                    width: double.infinity,
                    child: Consumer<AppViewModel>(
                        builder: (context, viewModel, child) {
                      return Column(
                        children: [
                          CheckboxListTile(
                              checkColor: Styles.surfaceColor,
                              activeColor: Styles.primaryColor,
                              title: const Text(
                                  "Pokaż wykres w widoku szczegółowym"),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: viewModel
                                  .stations[indexStation]
                                  .devices[indexDevice]
                                  .stationDetailsChartViewSelected,
                              onChanged: (onChanged) {
                                viewModel
                                    .setCheckBox1ParameterToDeviceInStation(
                                        indexDevice, indexStation, onChanged!);
                              }),
                          CheckboxListTile(
                              checkColor: Styles.surfaceColor,
                              activeColor: Styles.primaryColor,
                              title:
                                  const Text("Pokaż wykres w widoku ogólnym"),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: viewModel
                                  .stations[indexStation]
                                  .devices[indexDevice]
                                  .stationsChartViewSelected,
                              onChanged: (onChanged) {
                                viewModel
                                    .setCheckBox2ParameterToDeviceInStation(
                                        indexDevice, indexStation, onChanged!);
                              }),
                        ],
                      );
                    })), */
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Styles.primaryColor,
              ),
              child: Text(
                'Zapisz',
                style: TextStyle(
                  color: Styles.surfaceColor,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                viewModel.setNewParametersToDeviceInStation(
                    indexDevice,
                    indexStation,
                    nameTextController.text,
                    unitTextController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
