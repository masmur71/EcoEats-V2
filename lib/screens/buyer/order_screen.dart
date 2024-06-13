import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../services/api_service.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Order>> _futureOrders;

  @override
  void initState() {
    super.initState();
    _futureOrders = _apiService.fetchOrdersByPembeliId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pesanan'),
      ),
      body: FutureBuilder<List<Order>>(
        future: _futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Gagal memuat pesanan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada pesanan'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Pesanan #${order.id}'),
                  subtitle: Text(
                      'Total Pembayaran: Rp ${order.totalPembayaran}\nStatus: ${order.status}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
