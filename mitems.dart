
class ItemModel {
  final int id;
  final String merk;
  final int harga;
  final String nama_pembeli;

  ItemModel({
    required this.id,
    required this.merk,
    required this.harga,
    required this.nama_pembeli,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] ?? 0,
      merk: json['merk'] ?? '',
      harga: json['harga'] ?? 0,
      nama_pembeli: json['nama_pembeli'] ?? '',
    );  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'merk': merk,
    'harga': harga,
    'nama_pembeli': nama_pembeli,
  };
}