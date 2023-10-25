import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/stations_list/stations_list_builder/stations_list_builder.dart';
import 'package:test/views/widgets/custom_app_bars/custom_app_bar_for_stations_view.dart';
import 'package:test/views/widgets/floating_button/floating_action_button_view.dart';

class StationsListView extends StatelessWidget {
  const StationsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: CustomAppBarForStationsView(),
        body: SafeArea(
          //TODO https://stackoverflow.com/questions/51119795/how-to-remove-scroll-glow
          child: StationsListBuilder(viewModel: viewModel),
        ),
        floatingActionButton: const FloatingActionButtonView(),
      );
    });
  }
}
