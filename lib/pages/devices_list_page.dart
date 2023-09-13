import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/view_models/app_view_model.dart';

class DevicesListPage extends StatelessWidget {
  const DevicesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return ListView.builder(
        itemBuilder: (context, indexDevice) {
          return Container(
            color: Styles.surfaceColor,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.devices[indexDevice].name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'IP: ${viewModel.devices[indexDevice].ip}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Serial: ${viewModel.devices[indexDevice].serial}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Status: ${viewModel.devices[indexDevice].status}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
