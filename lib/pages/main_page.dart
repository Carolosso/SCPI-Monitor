import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/view_models/app_view_model.dart';
import 'package:test/views/stations_view.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Monitorowanie',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              )),
          backgroundColor: Colors.white24,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_rounded),
              color: Colors.black,
              iconSize: 40,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Dodawanie stanowiska'),
                        content: SingleChildScrollView(
                          child: TextField(
                            onSubmitted: (value) {
                              viewModel.createStation(value);
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                  bottom: 5,
                                ),
                                filled: true,
                                //fillColor: viewModel.clrlvl2,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none)),
                            autofocus: true,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            autocorrect: false,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Uzupełnij'),
                            onPressed: () {
                              viewModel.fillLists();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            )
          ],
        ),
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
