import 'package:flutter/material.dart';

class CustomNavBarSeller extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  CustomNavBarSeller({required this.selectedIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Pesanan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Kelola Toko',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
      ],
    );
  }
}
