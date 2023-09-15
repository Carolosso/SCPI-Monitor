import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/widgets/custom_app_bar.dart';

class DevicesListView extends StatelessWidget {
  const DevicesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Urządzenia (${viewModel.devicesCount})',
          dialogTitle: 'Dodaj urządzenie',
          viewModel: viewModel,
          showAction: true,
          showLeading: false,
          onActionTap: () {},
          onSubmit: viewModel.createDevice,
        ),
        body: ListView.builder(
          itemCount: viewModel.devices.length,
          itemBuilder: (context, indexDevice) {
            return GestureDetector(
              onTap: () => showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title:
                          Text('Edytuj ${viewModel.devices[indexDevice].name}'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              onSubmitted: (value) {
                                viewModel.devices[indexDevice].name = value;
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  filled: true,
                                  //fillColor: viewModel.clrlvl2,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none)),
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              autocorrect: false,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              child: DropdownButton<int>(
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
                          child: const Text('Zamknij'),
                          onPressed: () {
                            // onActionTap();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }),
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
                            color: Colors.green,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Numer Stanowiska: ${viewModel.devices[indexDevice].stationIndex}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )
                      ],
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
