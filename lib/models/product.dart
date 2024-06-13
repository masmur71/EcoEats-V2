class Product {
  final int id;
  final String nama;
  final String deskripsi;
  final int harga;
  final DateTime tglKadaluarsa;
  final String kategori;
  final int stok;
  final int penjualId;
  final String gambar;

  Product({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.tglKadaluarsa,
    required this.kategori,
    required this.stok,
    required this.penjualId,
    required this.gambar,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      harga: json['harga'],
      tglKadaluarsa: DateTime.parse(json['tglKadaluarsa']),
      kategori: json['kategori'],
      stok: json['stok'],
      penjualId: json['penjualId'],
      gambar: json['gambar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'harga': harga,
      'tglKadaluarsa': tglKadaluarsa.toIso8601String(),
      'kategori': kategori,
      'stok': stok,
      'penjualId': penjualId,
      'gambar': gambar,
    };
  }
}
