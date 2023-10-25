import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/views/widgets/floating_action_button_view.dart';

class StationDetailPage extends StatelessWidget {
  StationDetailPage({super.key, required this.stationIndex});

  final int stationIndex;

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController unitTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            clipBehavior: Clip.none,
            foregroundColor: Colors.black,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onSubmitted: (value) {
                    viewModel.setStationName(stationIndex, value);
                  },
                  // textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  autocorrect: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 5),
                    hintText: viewModel.stations[stationIndex].name,
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                const Text(
                  'Widok szczegołowy',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            //centerTitle: true,
            backgroundColor: Styles.backgroundColor,
            elevation: 0,
          ),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.stations[stationIndex].devices.length, //
          itemBuilder: (context, indexDevice) {
            return Dismissible(
              key: UniqueKey(),
              direction: viewModel.isStopped
                  ? DismissDirection.endToStart
                  : DismissDirection.none,
              onDismissed: (direction) {
                viewModel.removeDeviceFromStation(stationIndex, indexDevice);
                //Toast
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usunięto urządzenie.')));
              },
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.red.shade700,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    nameTextController.text = viewModel
                        .stations[stationIndex].devices[indexDevice].name;
                    unitTextController.text = viewModel.stations[stationIndex]
                        .devices[indexDevice].measuredUnit;
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                'Edytuj ${viewModel.devices[indexDevice].name}'),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: nameTextController,
                                    onSubmitted: (value) {},
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Styles.primaryColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Styles.surfaceColor)),
                                      labelText: ' Nazwa ',
                                    ),
                                    //autofocus: true,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                    autocorrect: false,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  TextField(
                                    controller: unitTextController,
                                    onSubmitted: (value) {},
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Styles.primaryColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Styles.surfaceColor)),
                                      labelText: ' Jednostka ',
                                    ),
                                    //autofocus: true,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                    autocorrect: false,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Zapisz'),
                                onPressed: () {
                                  viewModel.setNewParametersToDeviceInStation(
                                      indexDevice,
                                      stationIndex,
                                      nameTextController.text,
                                      unitTextController.text);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Styles.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            viewModel.stations[stationIndex]
                                .devices[indexDevice].name, //
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white), //??????
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Wartość mierzona',
                              style: TextStyle(
                                  fontSize: 8, color: Styles.surfaceColor),
                            ),
                          ),
                          Text(
                            '${viewModel.getDeviceValue(stationIndex, indexDevice)}${viewModel.getDeviceMeasuredUnit(stationIndex, indexDevice)}',
                            style: const TextStyle(
                                fontSize: 32,
                                //fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: const FloatingActionButtonView(),
      );
    });
  }
}
