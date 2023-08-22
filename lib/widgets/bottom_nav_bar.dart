import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/pages/add_page.dart';
import 'package:food_sales_recording_application/pages/history_page.dart';
import 'package:food_sales_recording_application/pages/home_page.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';

import '../pages/customer_page.dart';
import '../pages/menu_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List pages = [
    HomePage(),
    HistoryPage(),
    CustomerPage(),
    MenuPage(),
    AddPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Appcolors.darkColor,
        unselectedItemColor: Appcolors.darkGreyColor,
        backgroundColor: Appcolors.lightColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Customer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
        ],
      ),
    );
  }
}
