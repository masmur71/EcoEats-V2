import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import '../../services/api_service.dart';
import '../../models/product.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();

  String _nama = '';
  String _deskripsi = '';
  int _harga = 0;
  int _stok = 0;
  DateTime? _tanggalKadaluwarsa;
  String _kategori = '';
  File? _gambar;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _gambar = File(pickedFile.path);
      }
    });
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      try {
        if (_gambar != null) {
          // Step 1: Upload image
          final imageUrl = await _apiService.uploadImage(_gambar!);

          // Step 2: Create product with uploaded image URL
          final newProduct = Product(
            id: 12, // Assuming you generate id here
            nama: _nama,
            deskripsi: _deskripsi,
            harga: _harga,
            stok: _stok,
            penjualId: 1,
            tglKadaluarsa: _tanggalKadaluwarsa!,
            kategori: _kategori,
            gambar: imageUrl, // Use uploaded image URL
          );

          await _apiService.createProduct(newProduct, _gambar!);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Produk berhasil ditambahkan')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gambar produk harus diunggah')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambah produk: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Tambah Produk',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: 'Nama Produk',
                hintText: 'Ex: Es Teh Manis',
                maxLength: 150,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Masukkan nama produk';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nama = value ?? '';
                },
              ),
              SizedBox(height: 20),
              Text('Foto', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 253, 253, 253),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(255, 224, 224, 224),
                      width: 1,
                    ),
                  ),
                  child: _gambar == null
                      ? Center(
                          child: Icon(Icons.add_photo_alternate, size: 50),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(_gambar!, fit: BoxFit.cover),
                        ),
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(
                label: 'Deskripsi Produk',
                hintText: 'Ex: Es Teh Manis',
                maxLength: 250,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Masukkan deskripsi produk';
                  }
                  return null;
                },
                onSaved: (value) {
                  _deskripsi = value ?? '';
                },
              ),
              SizedBox(height: 20),
              _buildDropdownButtonFormField(
                label: 'Kategori Makanan',
                items: ['Makanan', 'Minuman', 'Jajanan'],
                onChanged: (value) {
                  setState(() {
                    _kategori = value!;
                  });
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Pilih kategori produk';
                  }
                  return null;
                },
                onSaved: (value) {
                  _kategori = value ?? '';
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Harga Produk',
                      hintText: 'Ex: Rp 5.000',
                      maxLength: 1000,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Masukkan harga produk';
                        }
                        if (int.tryParse(value ?? '') == null) {
                          return 'Masukkan angka yang valid';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _harga = int.parse(value ?? '0');
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: _buildTextField(
                      label: 'Tanggal Kadaluwarsa',
                      hintText: 'DD/MM/YYYY',
                      maxLength: 1000,
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Masukkan tanggal kadaluwarsa';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _tanggalKadaluwarsa =
                            DateFormat('dd/MM/yyyy').parse(value!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Satuan (gram)',
                      hintText: 'Ex: 500gr',
                      maxLength: 1000,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Masukkan satuan produk';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // Save the unit value if needed
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: _buildTextField(
                      label: 'Stok (Pcs)',
                      maxLength: 1000,
                      hintText: 'Ex: 10 pcs',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Masukkan stok produk';
                        }
                        if (int.tryParse(value ?? '') == null) {
                          return 'Masukkan angka yang valid';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _stok = int.parse(value ?? '0');
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Tambah Produk',
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required int maxLength,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 224, 224, 224),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: InputBorder.none,
          counterText: '',
        ),
        maxLength: maxLength,
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildDropdownButtonFormField({
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required FormFieldValidator<String?> validator,
    required FormFieldSetter<String?> onSaved,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 224, 224, 224),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        items: items
            .map((category) =>
                DropdownMenuItem(value: category, child: Text(category)))
            .toList(),
        onChanged: onChanged,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
