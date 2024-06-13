import 'package:flutter/material.dart';

class KeranjangBelanjaPage extends StatefulWidget {
  @override
  _KeranjangBelanjaPageState createState() => _KeranjangBelanjaPageState();
}

class _KeranjangBelanjaPageState extends State<KeranjangBelanjaPage> {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Donat Coklat',
      'price': 10000,
      'image': 'images/Donat.jpg',
      'quantity': 1,
      'controller': TextEditingController(text: '1')
    },
    {
      'name': 'Kue Lapis',
      'price': 15000,
      'image': 'images/Lapis.jpg',
      'quantity': 1,
      'controller': TextEditingController(text: '1')
    },
    {
      'name': 'Sarden',
      'price': 12000,
      'image': 'images/Sarden_ikan.jpg',
      'quantity': 1,
      'controller': TextEditingController(text: '1')
    },
  ];

  void updateQuantity(int index, int newQuantity) {
    setState(() {
      items[index]['quantity'] = newQuantity;
      items[index]['controller'].text = newQuantity.toString();
      if (items[index]['quantity'] < 1) {
        items[index]['quantity'] = 1; // Cegah jumlah negatif
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  int calculateTotalPrice() {
    int total = 0;
    for (var item in items) {
      int price = item['price'] as int;
      int quantity = item['quantity'] as int;
      total += price * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(items[index]['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items[index]['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors
                                          .grey), // Ubah warna ikon sampah
                                  onPressed: () {
                                    removeItem(index);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 4), // Ubah jarak antara baris
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rp ${items[index]['price']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFFF7A00),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        int newQuantity =
                                            items[index]['quantity'] - 1;
                                        updateQuantity(index, newQuantity);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .grey), // Border untuk tombol kurangi
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Icon(Icons.remove, size: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: items[index]['controller'],
                                        onChanged: (value) {
                                          int newQuantity =
                                              int.tryParse(value) ?? 1;
                                          updateQuantity(index, newQuantity);
                                        },
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                            fontSize:
                                                12), // Perkecil ukuran teks
                                        decoration: InputDecoration(
                                          border: InputBorder
                                              .none, // Hapus garis di bawah kuantitas
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        int newQuantity =
                                            items[index]['quantity'] + 1;
                                        updateQuantity(index, newQuantity);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .grey), // Border untuk tombol tambah
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Icon(Icons.add, size: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Harga:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${calculateTotalPrice()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7A00), // Ubah warna teks menjadi biru
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Tambahkan aksi yang diinginkan saat tombol ditekan
          },
          child: Text(
            'Lanjut Pesan',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor:
                Color(0xFFFF7A00), // Mengatur warna latar belakang tombol
          ),
        ),
      ),
    );
  }
}
