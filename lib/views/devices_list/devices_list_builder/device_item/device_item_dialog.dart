import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Styles.globalRadius)),
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
                Consumer<AppViewModel>(builder: (context, viewModel, child) {
                  return SizedBox(
                    child: DropdownButtonFormField<int>(
                        //dropdownColor: Styles.primaryColor,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Styles.primaryColor,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Styles.surfaceColor,
                            )),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Styles.globalRadius),
                            )),
                        borderRadius: BorderRadius.all(
                            Radius.circular(Styles.globalRadius)),
                        hint: viewModel.stations.isEmpty
                            ? const Text('brak stanowisk')
                            : const Text('wybierz stanowisko'),
                        value: null,
                        isExpanded: true,
                        items: viewModel.stations
                            .map((e) => DropdownMenuItem(
                                  value: viewModel.findStationIndex(e),
                                  child: Text(e.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700)),
                                ))
                            .toList(),
                        onChanged: (selectedStation) =>
                            viewModel.addDeviceToStation(selectedStation!,
                                viewModel.devices[indexDevice])),
                  );
                })
              ],
            ),
          ),
          actions: [
            TextButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Styles.primaryColor,
              ),
              child: Text(
                'Zapisz',
                style: TextStyle(color: Styles.surfaceColor),
              ),
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
