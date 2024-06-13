import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/api_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
      ),
      body: FutureBuilder<Product>(
        future: apiService.fetchProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child:
                    Text('Failed to load product details: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Product not found'));
          } else {
            final product = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(product.gambar, fit: BoxFit.cover),
                  SizedBox(height: 16),
                  Text(product.nama,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Kategori: ${product.kategori}',
                      style: TextStyle(fontSize: 16)),
                  Text(
                      'Tgl Kadaluwarsa: ${product.tglKadaluarsa.toString().split(' ')[0]}',
                      style: TextStyle(fontSize: 16)),
                  Text('Stok: ${product.stok} pcs',
                      style: TextStyle(fontSize: 16)),
                  Text('Jarak: 500 meter',
                      style: TextStyle(fontSize: 16)), // Dummy distance
                  SizedBox(height: 16),
                  Text('Tentang Produk',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(product.deskripsi, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Harga',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Rp ${product.harga}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await apiService.addToCart(
                            product.id, 1); // Gunakan product.id dan quantity 1
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Produk berhasil ditambahkan ke keranjang')),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add to cart: $e')),
                        );
                      }
                    },
                    child: Text('Pesan', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
