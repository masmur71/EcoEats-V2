import 'package:flutter/material.dart';
import 'detail_chat.dart'; // Import the new chat detail page

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'List Chat',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ChatTile(
            avatar: 'assets/avatar1.png', // Replace with the path to your avatar image
            name: 'Poppie',
            message: 'Masih Lama Gak yah?',
            date: '20 April 2024',
            unreadCount: 2,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatDetailPage(name: 'Poppie')),
              );
            },
          ),
          ChatTile(
            avatar: 'assets/avatar2.png', // Replace with the path to your avatar image
            name: 'Masmur',
            message: 'Makasih Ya Mas !',
            date: '20 April 2024',
            unreadCount: 1,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatDetailPage(name: 'Masmur')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String avatar;
  final String name;
  final String message;
  final String date;
  final int unreadCount;
  final VoidCallback onTap;

  ChatTile({
    required this.avatar,
    required this.name,
    required this.message,
    required this.date,
    required this.unreadCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(avatar),
        radius: 25,
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(message),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            date,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          if (unreadCount > 0)
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
