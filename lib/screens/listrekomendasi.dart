import 'package:flutter/material.dart';

// Kelas model untuk item rekomendasi
class Rekomendasi {
  final String imageUrl;
  final String title;
  final String details;
  final String distance;
  final String price;

  Rekomendasi({
    required this.imageUrl,
    required this.title,
    required this.details,
    required this.distance,
    required this.price,
  });
}

class ListRekomendasiPage extends StatelessWidget {
  // Daftar contoh item rekomendasi
  final List<Rekomendasi> rekomendasiList = [
    Rekomendasi(
      imageUrl: 'images/alpukat-salad.jpg',
      title: 'Kue Salad Alpukat',
      details: '500gr • 4 Pcs',
      distance: '0,73 Km',
      price: 'Rp 16.000',
    ),
    Rekomendasi(
      imageUrl: 'images/donat-box.jpg',
      title: 'Oui Oui Monsieour',
      details: '250gr • 3 Pcs',
      distance: '1,23 Km',
      price: 'Rp 18.000',
    ),
    Rekomendasi(
      imageUrl: 'images/donat-salju.jpg',
      title: 'Donat Salju Mantaf',
      details: '750gr • 1 Pcs',
      distance: '2,00 Km',
      price: 'Rp 50.000',
    ),
    // Tambahkan lebih banyak item sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Rekomendasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Rekomendasi Untukmu',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: rekomendasiList.length,
                itemBuilder: (context, index) {
                  final rekomendasi = rekomendasiList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          rekomendasi.imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                        title: Text(rekomendasi.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(rekomendasi.details),
                            Text(rekomendasi.distance),
                          ],
                        ),
                        trailing: Text(
                          rekomendasi.price,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
