import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/providers/app_view_model.dart';

class DevicesListView extends StatelessWidget {
  const DevicesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return ListView.builder(
        itemCount: viewModel.devices.length,
        itemBuilder: (context, indexDevice) {
          return Padding(
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
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
