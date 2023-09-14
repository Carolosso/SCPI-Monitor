import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/custom_app_bar_old.dart';
import 'package:test/views/device_list_view.dart';

class DevicesListPage extends StatelessWidget {
  const DevicesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: buildAppBar('Lista urządzeń', 'Dodaj urządzenie', context,
            viewModel, viewModel.createDevice, () {}),
        body: const SafeArea(
          child: Column(
            children: [
              //Task Info View
              Expanded(flex: 1, child: DevicesListView()),
              //Task List View
            ],
          ),
        ),
        //floatingActionButton: AddTaskView(),
      );
    });
  }
}
