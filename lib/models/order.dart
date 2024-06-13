class Order {
  final int id;
  final int pembeliId;
  final int penjualId;
  final int totalPembayaran;
  final String status;

  Order({
    required this.id,
    required this.pembeliId,
    required this.penjualId,
    required this.totalPembayaran,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      pembeliId: json['pembeliId'],
      penjualId: json['penjualId'],
      totalPembayaran: json['totalPembayaran'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pembeliId': pembeliId,
      'penjualId': penjualId,
      'totalPembayaran': totalPembayaran,
      'status': status,
    };
  }
}
