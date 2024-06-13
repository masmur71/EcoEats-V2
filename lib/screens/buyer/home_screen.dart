import 'package:ecoeats/screens/buyer/add_address_screen.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/api_service.dart';
import '../../widgets/product_card.dart';
import '../../widgets/custom_navbar.dart';
import '../buyer/cart_screen.dart';
import '../buyer/order_screen.dart';

class HomeScreenPm extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPm> {
  late Future<List<Product>> futureProducts;
  final ApiService apiService = ApiService();
  int _selectedIndex = 0;
  String _selectedCategory = 'Jajanan';

  @override
  void initState() {
    super.initState();
    futureProducts = apiService.fetchProducts();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopSection(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategori
                    Container(
                      height: 50.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _buildCategoryChip('Jajanan'),
                          _buildCategoryChip('Sayuran'),
                          _buildCategoryChip('Makanan K'),
                          _buildCategoryChip('Minuman'),
                          _buildCategoryChip('Buah-buahan'),
                        ],
                      ),
                    ),
                    // Rekomendasi Untukmu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rekomendasi Untukmu',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        Text('Lihat Semua',
                            style: TextStyle(color: Colors.green)),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    FutureBuilder<List<Product>>(
                      future: futureProducts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Failed to load products'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No products available'));
                        } else {
                          return SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                    product: snapshot.data![index]);
                              },
                            ),
                          );
                        }
                      },
                    ),
                    // Toko di Sekitarmu
                    Text('Toko di Sekitarmu',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16.0),
                    _buildStoreCard('Cake Mamah Salama', '0.73 km',
                        'Rp 3.000 - 15.000', 'images/Brownies.jpg'),
                    SizedBox(height: 8.0),
                    _buildStoreCard('Toko Kue MieMie Brownie', '0.73 km',
                        'Rp 3.000 - 15.000', 'images/Brownies.jpg'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16,
          left: 16,
          right: 16,
          bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFF379570),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Lokasi Sekarang',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 8),
                      Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  ),
                  Text('Dayeuhkolot, Jawa Barat',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              Icon(Icons.notifications, color: Colors.white),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Temukan menu favorit kamu',
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(label),
        selected: _selectedCategory == label,
        onSelected: (bool selected) {
          setState(() {
            _selectedCategory = selected ? label : '';
          });
        },
        selectedColor: Color(0xFFFF4F21),
        backgroundColor: Colors.grey[150],
        labelStyle: TextStyle(
            color: _selectedCategory == label ? Colors.white : Colors.black),
      ),
    );
  }
}

Widget _buildStoreCard(
    String name, String distance, String priceRange, String imagePath) {
  return Container(
    height: 100, // Perbesar tinggi container
    margin: EdgeInsets.symmetric(vertical: 8.0),
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
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
          child: Image.asset(
            imagePath,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(distance,
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                SizedBox(height: 4),
                Text(priceRange,
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
