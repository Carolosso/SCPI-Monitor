import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/navigation_view_model.dart';
import 'package:test/views/widgets/bottom_navbar/bottom_navigation_bar_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(builder: (context, siProvider, child) {
      return Scaffold(
        body: SafeArea(
          child: siProvider.pages[siProvider.screenIndex],
        ),
        bottomNavigationBar: buildBottomNavBar(context, siProvider),
        //floatingActionButton: AddTaskView(),
      );
    });
  }
}
