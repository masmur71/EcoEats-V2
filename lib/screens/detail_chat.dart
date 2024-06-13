import 'package:flutter/material.dart';

class ChatDetailPage extends StatelessWidget {
  final String name;

  ChatDetailPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          name,
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
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              ChatBubble(
                text: 'Halo Kak',
                isSentByMe: true,
                time: '20.34',
              ),
              ChatBubble(
                text: 'Sesuai Pesanan Ya Kak!',
                isSentByMe: true,
                time: '20.34',
              ),
              ChatBubble(
                text: 'Halo, min',
                isSentByMe: false,
                time: '20.36',
              ),
              ChatBubble(
                text: 'Masih Lama Gak yah?',
                isSentByMe: false,
                time: '20.39',
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.emoji_emotions_outlined, color: Colors.green),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan disini..',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.send, color: Colors.green),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final String time;

  ChatBubble({required this.text, required this.isSentByMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isSentByMe ? Colors.green : Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isSentByMe ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              time,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
