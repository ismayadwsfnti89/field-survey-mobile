import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService {
  static const String _baseUrl = 'https://sijala.biz.id/api/v1/users';
  static const String _dummyPassword = '123456';

  Future<UserModel> login(String email, String password) async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Gagal terhubung ke server (${response.statusCode})');
    }

    final decoded = jsonDecode(response.body);
    late final List<dynamic> data;

    if (decoded is List) {
      data = decoded;
    } else if (decoded is Map<String, dynamic>) {
      if (decoded['data'] is List) {
        data = decoded['data'];
      } else if (decoded['users'] is List) {
        data = decoded['users'];
      } else if (decoded['result'] is List) {
        data = decoded['result'];
      } else {
        throw Exception('Format response API tidak dikenali');
      }
    } else {
      throw Exception('Format response API tidak dikenali');
    }

    final List<UserModel> users =
        data.map((json) => UserModel.fromJson(json)).toList();

    // Penanganan null-safe pada user.email
    final matchedUser = users.where(
      (user) =>
          user.email != null &&
          user.email!.toLowerCase() == email.trim().toLowerCase(),
    );

    if (matchedUser.isEmpty) {
      throw Exception('Email tidak terdaftar');
    }

    if (password != _dummyPassword) {
      throw Exception('Password salah');
    }

    return matchedUser.first;
  }
}