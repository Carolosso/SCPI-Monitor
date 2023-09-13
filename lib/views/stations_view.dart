import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/view_models/app_view_model.dart';
import 'package:test/views/floating_action_button_view.dart';

class StationsMainView extends StatefulWidget {
  const StationsMainView({super.key});

  @override
  State<StationsMainView> createState() => _StationsMainViewState();
}

class _StationsMainViewState extends State<StationsMainView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        body: SafeArea(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: viewModel.stationsCount,
            itemBuilder: (context, indexStation) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Styles.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5),
                    child: Column(
                      children: <Widget>[
                        Text(
                          viewModel.getStationName(indexStation),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 1 / .4,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2),
                          itemCount:
                              viewModel.getStationsDevicesCount(indexStation),
                          itemBuilder: (context, indexDevice) {
                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              color: Styles.surfaceColor,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      //alignment: Alignment.centerLeft,
                                      flex: 1,
                                      child: Text(
                                        'Device ${indexDevice + 1}',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ), //??????
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      //alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${viewModel.getDeviceValue(indexStation, indexDevice).toStringAsFixed(3)} V',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          shrinkWrap:
                              true, // todo comment this out and check the result
                          physics:
                              const ClampingScrollPhysics(), // todo comment this out and check the result
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: const FloatingActionButtonView(),
      );
    });
  }
}
