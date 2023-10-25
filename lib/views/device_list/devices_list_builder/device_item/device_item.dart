import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/device_list/devices_list_builder/device_item/device_item_dialog.dart';

class DeviceItem extends StatelessWidget {
  const DeviceItem({
    super.key,
    required this.nameTextController,
    required this.viewModel,
    required this.ipTextController,
    required this.indexDevice,
  });

  final TextEditingController nameTextController;
  final AppViewModel viewModel;
  final TextEditingController ipTextController;
  final int indexDevice;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Styles.primaryColor,
          foregroundColor: Colors.white), //TODO STYLE THIS
      onPressed: () {
        nameTextController.text = viewModel.devices[indexDevice].name;
        ipTextController.text = viewModel.devices[indexDevice].ip;
        deviceItemDialog(context, viewModel, indexDevice, nameTextController,
            ipTextController);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: double.infinity,
          color: Styles.backgroundColor, //Styles.backgroundColor
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  viewModel.devices[indexDevice].name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 20,
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
                  'Manufacturer: ${viewModel.devices[indexDevice].manufacturer}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Model: ${viewModel.devices[indexDevice].model}',
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
                Row(
                  children: [
                    const Text(
                      'Status: ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      viewModel.devices[indexDevice].status,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        color: viewModel.devices[indexDevice].status == 'Online'
                            ? Styles.surfaceColor
                            : Colors.red,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
