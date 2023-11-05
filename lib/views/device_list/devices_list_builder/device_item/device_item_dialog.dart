import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

Future<void> deviceItemDialog(
    BuildContext context,
    AppViewModel viewModel,
    int indexDevice,
    TextEditingController nameTextController,
    TextEditingController ipTextController) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edytuj ${viewModel.devices[indexDevice].name}'),
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
                //IP FIELD
                /*     TextField(
                  controller: ipTextController,
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
                    labelText: ' IP ',
                  ),
                  //autofocus: true,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  autocorrect: false,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ), */
                //const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                SizedBox(
                  child: DropdownButton<int>(
                      /*   decoration: InputDecoration(
                            filled: true,
                            labelText: 'Stanowisko',
                          ), */
                      hint: viewModel.stations.isEmpty
                          ? const Text('brak stanowisk')
                          : const Text('wybierz stanowisko'),
                      isExpanded: true,
                      items: viewModel.stations
                          .map((e) => DropdownMenuItem(
                                value: viewModel.findStationIndex(e),
                                child: Text(e.name),
                              ))
                          .toList(),
                      onChanged: (selectedStation) =>
                          viewModel.addDeviceToStation(selectedStation!,
                              viewModel.devices[indexDevice])),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Zapisz'),
              onPressed: () {
                viewModel.setNewParametersToDeviceInList(indexDevice,
                    nameTextController.text, ipTextController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
