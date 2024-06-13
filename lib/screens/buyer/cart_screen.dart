import 'package:flutter/material.dart';
import '../../models/cart_item.dart';
import '../../services/api_service.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<CartItem>> _futureCartItems;

  @override
  void initState() {
    super.initState();
    _futureCartItems = _apiService.fetchCartItems();
  }

  void _refreshCart() {
    setState(() {
      _futureCartItems = _apiService.fetchCartItems();
    });
  }

  void _updateQuantity(int id, int newQuantity) async {
    try {
      await _apiService.updateCartItem(id, newQuantity);
      _refreshCart();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengupdate quantity: $e')),
      );
    }
  }

  void _removeItem(int id) async {
    try {
      await _apiService.removeCartItem(id);
      _refreshCart();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
      ),
      body: FutureBuilder<List<CartItem>>(
        future: _futureCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Gagal memuat keranjang: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Keranjang kosong'));
          } else {
            final cartItems = snapshot.data!;
            final subtotal = cartItems.fold(
              0,
              (total, item) => total + item.harga * item.quantity,
            );
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final imageUrl =
                          'http://192.168.18.13:5000/${item.gambar}'; // pastikan hanya sekali digabungkan
                      return ListTile(
                        leading: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(item.nama),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jumlah: ${item.quantity}'),
                            Text('Rp. ${item.harga}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (item.quantity > 1) {
                                  _updateQuantity(item.id, item.quantity - 1);
                                }
                              },
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                _updateQuantity(item.id, item.quantity + 1);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _removeItem(item.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal', style: TextStyle(fontSize: 18)),
                          Text('Rp. $subtotal', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            final response = await _apiService.createOrder(
                              1, // penjualId dummy
                              subtotal,
                              cartItems,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Pesanan berhasil dibuat')),
                            );
                            _refreshCart();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Gagal membuat pesanan: $e')),
                            );
                          }
                        },
                        child: Text('Pesan',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
