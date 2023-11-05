import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/device_list/devices_list_builder/device_item/device_item.dart';
import 'package:test/views/widgets/snackbar/show_snackbar.dart';

class DevicesListBuilder extends StatelessWidget {
  const DevicesListBuilder({
    super.key,
    required this.nameTextController,
    required this.ipTextController,
    required this.viewModel,
  });

  final TextEditingController nameTextController;
  final TextEditingController ipTextController;
  final AppViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewModel.devices.length,
      itemBuilder: (context, indexDevice) {
        return Dismissible(
          key: UniqueKey(),
          direction: viewModel.isStopped
              ? DismissDirection.endToStart
              : DismissDirection.none,
          onDismissed: (direction) {
            viewModel.removeDeviceFromList(indexDevice);
            HapticFeedback.lightImpact(); //vibration
            //Toast
            showSnackBar(context, "Usunięto urządzenie");
          },
          background: Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.red.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.delete,
              color: Colors.red.shade700,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: DeviceItem(
                nameTextController: nameTextController,
                viewModel: viewModel,
                ipTextController: ipTextController,
                indexDevice: indexDevice),
          ),
        );
      },
    );
  }
}
