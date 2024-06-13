import 'package:flutter/material.dart';
import '../../models/address.dart';
import '../../services/api_service.dart';
import 'address_list_screen.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _buildingController = TextEditingController();
  final _addressController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _buildingController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Address newAddress = Address(
        id: 0, // Id akan diatur oleh database
        pembeliId: 1, // Id pembeli default
        namaPenerima: _nameController.text,
        nomorTelepon: _phoneController.text,
        namaGedung: _buildingController.text,
        alamatLengkap: _addressController.text,
      );

      try {
        await _apiService.addAddress(newAddress);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alamat berhasil ditambahkan')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan alamat: $e')),
        );
      }
    }
  }

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
        title: Text('Tambah Alamat'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressListScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Penerima',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Penerima tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Nomor Telepon',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Nama Gedung',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _buildingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Gedung tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Alamat Lengkap',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat Lengkap tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Tambah Alamat',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 24),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
