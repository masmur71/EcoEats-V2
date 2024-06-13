import 'package:flutter/material.dart';

class JamOperasionalPage extends StatefulWidget {
  @override
  _JamOperasionalPageState createState() => _JamOperasionalPageState();
}

class _JamOperasionalPageState extends State<JamOperasionalPage> {
  bool _isOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Jam Operasional'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jam Operasional Reguler',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            buildDayRow('Senin'),
            SizedBox(height: 10),
            buildDayRow('Selasa'),
            SizedBox(height: 10),
            buildDayRow('Rabu'),
            SizedBox(height: 10),
            buildDayRow('Kamis'),
            SizedBox(height: 10),
            buildDayRow('Jumat'),
            SizedBox(height: 10),
            buildDayRow('Sabtu'),
            SizedBox(height: 10),
            buildDayRow('Minggu'),
          ],
        ),
      ),
    );
  }

  Widget buildDayRow(String day) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50, // Memberikan lebar tetap untuk teks hari
          child: Text(day),
        ),
        Switch(
          value: _isOpen,
          onChanged: (value) {
            setState(() {
              _isOpen = value;
            });
          },
          activeTrackColor: Colors.orange,
          activeColor: Colors.white,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Open',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
                keyboardType: TextInputType.datetime,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Close',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
                keyboardType: TextInputType.datetime,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
