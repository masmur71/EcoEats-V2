import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../screens/buyer/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(productId: product.id),
          ),
        );
      },
      child: Container(
        width: 150,
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
              child: Image.network(
                product.gambar,
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
                  Text(
                    product.nama,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Stok: ${product.stok}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 12),
                      SizedBox(width: 4),
                      Text(
                        '4.8', // Dummy text for rating
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
