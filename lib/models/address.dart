class Address {
  final int id;
  final int pembeliId;
  final String namaPenerima;
  final String nomorTelepon;
  final String namaGedung;
  final String alamatLengkap;

  Address({
    required this.id,
    required this.pembeliId,
    required this.namaPenerima,
    required this.nomorTelepon,
    required this.namaGedung,
    required this.alamatLengkap,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      pembeliId: json['pembeliId'],
      namaPenerima: json['namaPenerima'],
      nomorTelepon: json['nomorTelepon'],
      namaGedung: json['namaGedung'],
      alamatLengkap: json['alamatLengkap'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pembeliId': pembeliId,
      'namaPenerima': namaPenerima,
      'nomorTelepon': nomorTelepon,
      'namaGedung': namaGedung,
      'alamatLengkap': alamatLengkap,
    };
  }
}
