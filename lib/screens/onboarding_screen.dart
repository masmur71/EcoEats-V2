import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    Widget PilihUser() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/login-pembeli'),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.asset('images/pembeli.jpg'),
                    SizedBox(
                        width: 8), // Menambahkan jarak antara gambar dan teks
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Masuk sebagai Pembeli',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Beli produk dengan harga miring',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Spacer(), // Untuk memberi ruang di sisi kanan
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/login-penjual'),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.asset('images/mitra.jpg'),
                    SizedBox(
                        width: 8), // Menambahkan jarak antara gambar dan teks
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Masuk sebagai Mitra',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Jual makanan dari toko-mu',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Spacer(), // Untuk memberi ruang di sisi kanan
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'images/Background.jpg',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.asset('images/logoputih.png'),
                        SizedBox(height: 8),
                        Text(
                          'Selamatkan Lingkungan, Selamatkan\nDompetmu, Mulai Sekarang!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 220),
                    PilihUser(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: content(),
      ),
    );
  }
}
