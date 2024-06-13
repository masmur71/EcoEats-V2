import 'package:flutter/material.dart';
import '../../models/address.dart';
import '../../services/api_service.dart';

class EditAddressScreen extends StatefulWidget {
  final Address address;

  const EditAddressScreen({Key? key, required this.address}) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _buildingController = TextEditingController();
  final _addressController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.address.namaPenerima;
    _phoneController.text = widget.address.nomorTelepon;
    _buildingController.text = widget.address.namaGedung;
    _addressController.text = widget.address.alamatLengkap;
  }

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
      Address updatedAddress = Address(
        id: widget.address.id,
        pembeliId: 1, // Id pembeli default
        namaPenerima: _nameController.text,
        nomorTelepon: _phoneController.text,
        namaGedung: _buildingController.text,
        alamatLengkap: _addressController.text,
      );

      try {
        await _apiService.updateAddress(updatedAddress);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alamat berhasil diperbarui')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui alamat: $e')),
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
        title: Text('Edit Alamat'),
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
                    'Perbarui Alamat',
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
