import 'package:flutter/material.dart';
import 'package:test/providers/navigation_view_model.dart';

BottomNavigationBar buildBottomNavBar(
    BuildContext context, ScreenIndexProvider siModel) {
  return BottomNavigationBar(
    selectedItemColor: Colors.black,
    currentIndex: siModel.screenIndex,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Stanowiska'),
      BottomNavigationBarItem(
          icon: Icon(Icons.perm_device_information), label: 'Urządzenia'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ustawienia'),
    ],
    onTap: (value) => siModel.updateScreenIndex(value),
  );
}
