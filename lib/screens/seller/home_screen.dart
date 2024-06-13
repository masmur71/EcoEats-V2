
import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../services/api_service.dart';
import '../../widgets/custom_navbar_seller.dart';

 // Tambahkan impor ini

class HomeScreenPj extends StatefulWidget {
  @override
  _HomeScreenPjState createState() => _HomeScreenPjState();
}

class _HomeScreenPjState extends State<HomeScreenPj> {
  int _currentIndex = 0;
  late Future<List<Order>> futureOrders;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureOrders = apiService
        .fetchOrdersBySellerId(1); // Ganti dengan ID penjual sebenarnya
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/homepage-pembeli');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/orders');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/kelola-toko');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/chat');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back
        title: Padding(
          padding: const EdgeInsets.only(
              bottom: 8.0), // Menambahkan padding di bawah AppBar
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                    'images/profil-toko.jpg'), // Ganti dengan gambar profil penjual
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Toko Kue MieMie Brownie',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      // Aksi untuk mengedit profil
                    },
                    child: Text('Edit Profil',
                        style: TextStyle(color: Colors.green, fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Aksi untuk melihat notifikasi
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExpiredProductsSection(),
              SizedBox(height: 16),
              _buildOperationalHoursSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBarSeller(
        selectedIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  Widget _buildExpiredProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Produk Kadaluwarsa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                // Aksi untuk mengelola produk
              },
              child: Text('Kelola', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildExpiredProductCard('Kue Salad Alpukat',
                  'Kadaluwarsa 3 Mei 2023', 'images/kdl-alpukat-salad.jpg'),
              _buildExpiredProductCard('Donat Salju', 'Kadaluwarsa 3 Mei 2023',
                  'images/kdl-donat-box.jpg'),
              _buildExpiredProductCard('Kue Lapis', 'Kadaluwarsa 4 Mei 2023',
                  'images/kdl-kue-lapis.jpg'),
              _buildExpiredProductCard('Brownie', 'Kadaluwarsa 5 Mei 2023',
                  'images/kdl-brownis.jpg'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpiredProductCard(
      String name, String expiryDate, String imagePath) {
    return Container(
      width: 160,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(expiryDate,
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationalHoursSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Jam Operasional',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                // Navigasi ke halaman edit jam operasional
              },
              child: Row(
                children: [
                  Text('Edit',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Icon(Icons.edit, color: Colors.grey, size: 12),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text('Sen - Jum: 9:00 AM - 9:00 PM'),
        Text('Sab: 9:00 AM - 11:00 PM'),
        Text('Min: Tutup 24 jam'),
      ],
    );
  }

  
      
    
  }

 
  
