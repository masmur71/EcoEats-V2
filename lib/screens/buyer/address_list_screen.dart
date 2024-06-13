import 'package:flutter/material.dart';
import '../../models/address.dart';
import '../../services/api_service.dart';
import '../buyer/edit_addres_screen.dart';


class AddressListScreen extends StatefulWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Address>> _futureAddresses;

  @override
  void initState() {
    super.initState();
    _futureAddresses = _apiService.fetchAddresses(1);
  }

  void _refreshAddresses() {
    setState(() {
      _futureAddresses = _apiService.fetchAddresses(1);
    });
  }

  void _deleteAddress(int id) async {
    try {
      await _apiService.deleteAddress(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Alamat berhasil dihapus')),
      );
      _refreshAddresses();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus alamat: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Alamat'),
      ),
      body: FutureBuilder<List<Address>>(
        future: _futureAddresses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat alamat: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada alamat'));
          } else {
            final addresses = snapshot.data!;
            return ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return ListTile(
                  title: Text(address.namaPenerima),
                  subtitle: Text('${address.alamatLengkap}, ${address.namaGedung}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAddressScreen(address: address),
                            ),
                          ).then((_) => _refreshAddresses());
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteAddress(address.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
