import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/device_list/devices_list_builder/devices_list_builder.dart';
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
        body: RefreshIndicator(
          color: Styles.primaryColor,
          backgroundColor: Styles.surfaceColor,
          onRefresh: viewModel.refreshFunction, //
          child: DevicesListBuilder(
            nameTextController: nameTextController,
            ipTextController: ipTextController,
            viewModel: viewModel,
          ),
        ),
      );
    });
  }
}
