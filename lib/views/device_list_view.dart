import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/widgets/custom_app_bars/custom_app_bar_for_devices_view.dart';

class DevicesListView extends StatelessWidget {
  DevicesListView({super.key});

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController ipTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: CustomAppBarForDevicesView(),
        body: ListView.builder(
          itemCount: viewModel.devices.length,
          itemBuilder: (context, indexDevice) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                viewModel.removeDeviceFromList(indexDevice);
              },
              background: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.red.shade700,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  nameTextController.text = viewModel.devices[indexDevice].name;
                  ipTextController.text = viewModel.devices[indexDevice].ip;

                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                              'Edytuj ${viewModel.devices[indexDevice].name}'),
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
                                        borderSide: BorderSide(
                                            color: Styles.primaryColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Styles.surfaceColor)),
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
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10)),
                                TextField(
                                  controller: ipTextController,
                                  onSubmitted: (value) {},
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Styles.primaryColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Styles.surfaceColor)),
                                    labelText: ' IP ',
                                  ),
                                  //autofocus: true,
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.center,
                                  autocorrect: false,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10)),
                                SizedBox(
                                  child: DropdownButton<int>(
                                      hint: const Text('Dodaj do stanowiska Ω'),
                                      isExpanded: true,
                                      //value: viewModel.devices[indexDevice].stationIndex,
                                      items: viewModel.stations
                                          .map((e) => DropdownMenuItem(
                                                value: e.stationID,
                                                child: Text(e.name),
                                              ))
                                          .toList(),
                                      onChanged: (selectedStation) =>
                                          viewModel.addDeviceToStation(
                                              selectedStation! - 1,
                                              viewModel.devices[indexDevice])),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Zapisz'),
                              onPressed: () {
                                viewModel.setNewParametersToDevice(
                                    indexDevice,
                                    nameTextController.text,
                                    ipTextController.text);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    color: Styles.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.devices[indexDevice].name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'App ID: ${viewModel.devices[indexDevice].deviceID}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'IP: ${viewModel.devices[indexDevice].ip}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Serial: ${viewModel.devices[indexDevice].serial}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Status: ${viewModel.devices[indexDevice].status}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
/*                           Text(
                            'Numer Stanowiska: ${viewModel.devices[indexDevice].stationIndex}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ) */
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
