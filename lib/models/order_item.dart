class OrderItem {
  final int id;
  final int produkId;
  final String namaProduk;
  final int quantity;
  final int harga;

  OrderItem({
    required this.id,
    required this.produkId,
    required this.namaProduk,
    required this.quantity,
    required this.harga,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      produkId: json['produkId'],
      namaProduk: json['namaProduk'],
      quantity: json['quantity'],
      harga: json['harga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'produkId': produkId,
      'namaProduk': namaProduk,
      'quantity': quantity,
      'harga': harga,
    };
  }
}
