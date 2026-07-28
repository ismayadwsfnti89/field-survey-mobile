// Model ini merepresentasikan satu object "user" dari response API.
// Gunanya supaya data JSON (Map<String, dynamic>) diubah jadi objek Dart
// yang lebih aman dipakai (ada tipe data jelas: int, String, dll),
// daripada terus-terusan akses lewat json['name'], json['email'] manual.

class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  // "Factory constructor" -> cara bikin objek UserModel dari data JSON (Map).
  // Dipanggil kayak: UserModel.fromJson(jsonData)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}