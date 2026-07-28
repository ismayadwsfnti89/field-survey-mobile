import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

// Class ini isinya khusus logic yang berhubungan sama autentikasi (login).
// Dipisah dari UI (login.dart) supaya:
// 1. login.dart cuma fokus urus tampilan
// 2. logic API-nya bisa dipakai ulang di halaman lain kalau perlu
// 3. gampang di-testing / diganti nanti kalau backend sudah punya endpoint login asli

class AuthService {
  // Ganti sesuai endpoint API kamu
  static const String _baseUrl = 'https://sijala.biz.id/api/v1-users';

  // SEMENTARA: password di-hardcode "123456" untuk semua user,
  // karena API list user ini belum punya endpoint login/password asli.
  // TODO: hapus constant ini begitu backend sudah punya endpoint POST /login
  static const String _dummyPassword = '123456';

  /// Mengembalikan UserModel kalau email & password valid.
  /// Melempar Exception (dengan pesan error) kalau gagal.
  Future<UserModel> login(String email, String password) async {
    // 1. Ambil data semua user dari API
    final response = await http.get(Uri.parse(_baseUrl));

    // 2. Cek status response HTTP-nya dulu (200 = OK)
    if (response.statusCode != 200) {
      throw Exception('Gagal terhubung ke server (${response.statusCode})');
    }

    // 3. Ubah response (String JSON) jadi Map yang bisa dibaca Dart
    final Map<String, dynamic> body = jsonDecode(response.body);

    if (body['success'] != true) {
      throw Exception('Server merespon dengan status gagal');
    }

    // 4. Ambil list data user, lalu ubah tiap item jadi UserModel
    final List<dynamic> data = body['data'];
    final List<UserModel> users =
        data.map((json) => UserModel.fromJson(json)).toList();

    // 5. Cari user yang emailnya cocok (case-insensitive biar lebih toleran)
    final matchedUser = users.where(
      (user) => user.email.toLowerCase() == email.toLowerCase(),
    );

    if (matchedUser.isEmpty) {
      throw Exception('Email tidak terdaftar');
    }

    // 6. Cek password (sementara dibandingkan ke password dummy)
    if (password != _dummyPassword) {
      throw Exception('Password salah');
    }

    // 7. Kalau lolos semua pengecekan, return user yang login
    return matchedUser.first;
  }
}