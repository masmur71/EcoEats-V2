import 'package:flutter/material.dart';
import 'package:ecoeats/models/order_item.dart'; // Pastikan path impor sesuai dengan lokasi OrderItem

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItem;

  OrderItemWidget({required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(orderItem.namaProduk),
        subtitle:
            Text('Quantity: ${orderItem.quantity}, Price: ${orderItem.harga}'),
        trailing: Text('Total: ${orderItem.quantity * orderItem.harga}'),
      ),
    );
  }
}
