class User {
  final int id;
  final String nama;
  final String password;
  final String alamat;
  final String? namaToko;

  User({
    required this.id,
    required this.nama,
    required this.password,
    required this.alamat,
    this.namaToko,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      password: json['password'],
      alamat: json['alamat'],
      namaToko: json['namaToko'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'password': password,
      'alamat': alamat,
      'namaToko': namaToko,
    };
  }
}
