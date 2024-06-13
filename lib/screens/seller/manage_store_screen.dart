import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/api_service.dart';
import '../../widgets/custom_navbar_seller.dart';

class ManageStoreScreen extends StatefulWidget {
  @override
  _ManageStoreScreenState createState() => _ManageStoreScreenState();
}

class _ManageStoreScreenState extends State<ManageStoreScreen> {
  List<Product> _products = [];
  bool _isLoading = true;
  int _currentIndex = 2; // Set current index to 2 for manage store

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    try {
      ApiService apiService = ApiService();
      List<Product> products = await apiService.fetchProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/homepage-penjual');
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Center(
          child: Text(
            'Kelola Toko',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Container(
            width: 40, // This ensures the title is centered
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Toko
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/profil-toko.jpg'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Toko Kue MieMie Brownie',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Jl. Kopo Sayati No.20',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman edit profil
                          },
                          child: Row(
                            children: [
                              Text('Edit Profil',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green)),
                              Icon(Icons.edit, color: Colors.green, size: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Navigasi ke halaman edit profil
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Jam Operasional
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Jam Operasional',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            _buildOperatingHours(),
            SizedBox(height: 20),

            // Laporan Penjualan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Laporan Penjualan',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.print),
                  onPressed: () {
                    // Fungsi cetak laporan
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            _buildSalesReport(),
            SizedBox(height: 20),

            // Etalase Produk
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Etalase Produk',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/add-product');
                  },
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context,
                              '/tambah-produk'); // Navigasi ke halaman tambah produk
                        },
                        child: Row(
                          children: [
                            Text('Tambah Produk',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            Icon(Icons.add, color: Colors.grey, size: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _buildProductShelf(),
            SizedBox(height: 20),

            // Produk Kadaluwarsa
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Produk Kadaluwarsa',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman kelola produk kadaluwarsa
                  },
                  child: Row(
                    children: [
                      Text('Kelola',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Icon(Icons.edit, color: Colors.grey, size: 12),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            _buildExpiredProducts(),
            SizedBox(height: 15),

            // Kelola Transaksi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Kelola Transaksi',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman kelola transaksi
                  },
                  child: Text('Lihat Semua',
                      style: TextStyle(fontSize: 12, color: Colors.green)),
                ),
              ],
            ),
            SizedBox(height: 15),
            _buildTransactionList(),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBarSeller(
        selectedIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  Widget _buildOperatingHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOperatingHourRow('Sen - Jum', '9:00 AM - 9:00 PM'),
        _buildOperatingHourRow('Sab', '9:00 AM - 11:00 PM'),
        _buildOperatingHourRow('Min', 'Tutup 24 Jam'),
      ],
    );
  }

  Widget _buildOperatingHourRow(String day, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(day, style: TextStyle(fontSize: 14)),
        Text(time, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildSalesReport() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildReportCard('Produk Terjual', '40'),
        _buildReportCard('Total Transaksi', '15'),
        _buildReportCard('Produk Kadaluwarsa', '4'),
      ],
    );
  }

  Widget _buildReportCard(String title, String value) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildProductShelf() {
    return Container(
      height: 145,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _products.length,
        itemBuilder: (context, index) {
          Product product = _products[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.gambar,
              height: 100,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(product.nama, style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Qty: ${product.stok}',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildExpiredProducts() {
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildExpiredProductCard('Kue Salad Alpukat',
              'Kadaluwarsa 3 Mei 2023', 'images/kdl-alpukat-salad.jpg'),
          _buildExpiredProductCard('Donat Salju', 'Kadaluwarsa 3 Mei 2023',
              'images/kdl-donat-box.jpg'),
          _buildExpiredProductCard(
              'Brownies', 'Kadaluwarsa 3 Mei 2023', 'images/kdl-brownis.jpg'),
        ],
      ),
    );
  }

  Widget _buildExpiredProductCard(
      String name, String expiryDate, String imagePath) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              height: 80,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(expiryDate, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Column(
      children: [
        _buildTransactionCard(
            'No Pesanan: 98212646', 'Rp 15.000', Colors.orange),
        _buildTransactionCard(
            'No Pesanan: 98212647', 'Rp 15.000', Colors.green),
      ],
    );
  }

  Widget _buildTransactionCard(
      String orderNumber, String totalPayment, Color statusColor) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(orderNumber,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('Status',
                      style: TextStyle(color: statusColor, fontSize: 12)),
                ),
              ],
            ),
            SizedBox(height: 5),
            _buildTransactionItem(
                'Sarden Ikan Asin Konghuan', '1x', 'Rp 5.000'),
            _buildTransactionItem('Es Teh Manis', '1x', 'Rp 5.000'),
            _buildTransactionItem('Es Cendol', '1x', 'Rp 5.000'),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Pembayaran',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(totalPayment,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String itemName, String quantity, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(itemName),
        Text('$quantity $price'),
      ],
    );
  }
}
