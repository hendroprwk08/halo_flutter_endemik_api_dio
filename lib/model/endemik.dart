/*
 class ini digunakan sebagai bentuk struktur data
 fungsinya mirip seperti sebuah tabel pada basis data
*/
class Endemik {
  late final String id, nama, nama_latin, deskripsi, asal, foto, status;

  Endemik({
    required this.id,
    required this.nama,
    required this.nama_latin,
    required this.deskripsi,
    required this.asal,
    required this.foto,
    required this.status,
  });

  // penampung data dari json
  factory Endemik.fromJson(Map<String, dynamic> json) {
    return Endemik(
      id: json["id"],
      nama: json["nama"],
      nama_latin: json["nama_latin"],
      deskripsi: json["deskripsi"],
      asal: json["asal"],
      foto: json["foto"],
      status: json["status"],
    );
  }
}
