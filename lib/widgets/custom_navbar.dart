// Tambahkan import untuk CartScreen, AddAddressScreen, dan OrderScreen
import '../screens/buyer/cart_screen.dart';
import '../screens/buyer/add_address_screen.dart'; // Pastikan path impor sesuai dengan lokasi AddAddressScreen
import '../screens/buyer/order_screen.dart'; // Pastikan path impor sesuai dengan lokasi OrderScreen
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  CustomNavBar({required this.selectedIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        onTabTapped(index);
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderScreen()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAddressScreen()),
          );
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Pesanan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Keranjang',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Alamat',
        ),
      ],
      unselectedItemColor: Color(0xFFA8A8A8), // Warna ikon saat tidak aktif
      selectedItemColor: Color(0xFF379570), // Warna ikon saat aktif
    );
  }
}
