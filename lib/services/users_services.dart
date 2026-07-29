import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'https://sijala.biz.id/api/v1/users';

  // Mengambil seluruh daftar user dari API
  static Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Gagal mengambil data user (${response.statusCode})');
    }
  }

  // Cek apakah email yang diinput ada di daftar user
  static Future<Map<String, dynamic>?> findUserByEmail(String email) async {
    final users = await getUsers();
    for (final user in users) {
      if (user['email'].toString().toLowerCase() == email.toLowerCase()) {
        return user as Map<String, dynamic>;
      }
    }
    return null;
  }
}
