class CartItem {
  final int id;
  final int pembeliId;
  final int produkId;
  final int quantity;
  final String gambar;
  final String nama;
  final int harga;

  CartItem({
    required this.id,
    required this.pembeliId,
    required this.produkId,
    required this.quantity,
    required this.gambar,
    required this.nama,
    required this.harga,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      pembeliId: json['pembeliId'],
      produkId: json['produkId'],
      quantity: json['quantity'],
      gambar: json['gambar'],
      nama: json['nama'],
      harga: json['harga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pembeliId': pembeliId,
      'produkId': produkId,
      'quantity': quantity,
      'gambar': gambar,
      'nama': nama,
      'harga': harga,
    };
  }
}
