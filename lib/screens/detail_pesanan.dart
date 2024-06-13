import 'package:flutter/material.dart';

class DetailPesananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Warna putih
        elevation: 0, // Menghapus bayangan di bawah app bar
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: const Color.fromARGB(255, 0, 0, 0)), // Icon backward
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text(
          'Detail Pesanan',
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0), // Warna teks hitam
            fontSize: 20, // Ukuran teks
          ),
        ),
        centerTitle: true, // Teks berada di tengah
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris untuk foto profil, nama, dan ikon bubble chat
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage('images/Avatar.jpg'), // Pastikan path benar
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Poppie',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.green, size: 16),
                            SizedBox(width: 4),
                            Text(
                              '0,52km. Jalan Bojong Soang',
                              style: TextStyle(
                                  color: Colors.green, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.chat_bubble, color: Colors.green),
                      onPressed: () {
                        // Aksi untuk ikon bubble chat
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20), // Spasi antara jam operasional dan produk terlaris
                Text(
                  'Produk Pesanan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10), // Spasi antara judul dan item pesanan
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        image: DecorationImage(
                          image: AssetImage(
                              'images/Nasi_goreng.jpg'), // Ganti dengan path gambar makanan
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sarden Ikan Asin Khonguan',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '500gr',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Rp 5000',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '1x',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Spasi antara judul dan item pesanan
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        image: DecorationImage(
                          image: AssetImage(
                              'images/teh.jpg'), // Ganti dengan path gambar makanan
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Es Teh Manis',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '500gr',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Rp 5000',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '1x',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Spasi antara judul dan item pesanan
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        image: DecorationImage(
                          image: AssetImage(
                              'images/Cendol.jpg'), // Ganti dengan path gambar makanan
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Es Cendol',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '500gr',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Rp 5000',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '1x',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Spasi antara item pesanan dan tombol
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Aksi untuk tombol Terima Pesanan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Warna latar belakang tombol Terima Pesanan
                    padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 15), // Ubah padding tombol
                  ),
                  child: Text(
                    'Terima Pesanan',
                    style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10), // Spasi antara tombol Terima Pesanan dan tombol Tolak Pesanan
                ElevatedButton(
                  onPressed: () {
                    // Aksi untuk tombol Tolak Pesanan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Warna latar belakang tombol Tolak Pesanan
                    padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 15), // Ubah padding tombol
                  ),
                  child: Text(
                    'Tolak Pesanan',
                    style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
