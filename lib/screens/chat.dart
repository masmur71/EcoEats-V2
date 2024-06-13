import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Chats',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildChatItem(
            context,
            'Poppie',
            'Masih Lama Gak yah?',
            '20 April 2024',
            '2',
            'images/profile1.jpg', // ganti dengan path ke gambar Anda
          ),
          _buildChatItem(
            context,
            'Masmur',
            'Makasi Ya Mas !',
            '20 April 2024',
            '1',
            'images/profile2.jpg', // ganti dengan path ke gambar Anda
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          // Logika untuk mengubah halaman
          // Tambahkan navigasi ke halaman yang sesuai berdasarkan index
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Kelola Toko',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        selectedItemColor: Color(0xFF379570),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, String name, String message,
      String date, String unreadCount, String imagePath) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
        radius: 25,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(message),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              unreadCount,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      onTap: () {
        // Navigasi ke halaman chat detail
      },
    );
  }
}
