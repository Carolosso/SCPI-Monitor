import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/view_models/app_view_model.dart';
import 'package:test/views/navigation_bar_sheet_view.dart';
import 'package:test/views/stations_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: buildAppBar(
            'Monitorowanie', context, viewModel, viewModel.createStation),
        body: const SafeArea(
          child: Column(
            children: [
              //Task Info View
              Expanded(flex: 1, child: StationsMainView()),
              //Task List View
            ],
          ),
        ),
        //floatingActionButton: AddTaskView(),
      );
    });
  }
}
