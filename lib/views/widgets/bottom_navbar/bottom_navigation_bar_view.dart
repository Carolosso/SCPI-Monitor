import 'package:flutter/material.dart';
import 'package:test/providers/navigation_view_model.dart';
import 'package:test/style/theme.dart';

Container buildBottomNavBar(BuildContext context, ScreenIndexProvider siModel) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      boxShadow: [
        BoxShadow(color: Colors.black26, spreadRadius: 1, blurRadius: 3)
      ],
    ),
    //ClipRRect widget for Round Corner
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: BottomNavigationBar(
        selectedItemColor: Styles.primaryColor,
        //unselectedItemColor: Styles.primaryColor,
        currentIndex: siModel.screenIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Stanowiska'),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_device_information), label: 'Urządzenia'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Ustawienia'),
        ],
        onTap: (value) => siModel.updateScreenIndex(value),
      ),
    ),
  );
}
