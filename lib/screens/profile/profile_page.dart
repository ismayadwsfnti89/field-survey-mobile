import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class ProfilePage extends StatelessWidget {
  final UserModel? user;

  const ProfilePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    // Mengambil data user atau menggunakan nilai default jika null
    final String name = user?.name ?? 'Ismaya Dewi Sofianti';
    final String email = user?.email ?? 'ismaya@email.com';
    final String phone = user?.phone ?? '089507868792';
    final String gender = (user?.gender == 'L' || user?.gender == 'Laki-laki')
        ? 'Laki-laki'
        : (user?.gender == 'P' || user?.gender == 'Perempuan')
            ? 'Perempuan'
            : 'Perempuan';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Foto Avatar Pengguna
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  size: 55,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Teks Nama
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Card Berisi Biodata
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.badge_outlined, color: Colors.blue),
                      title: const Text('Nama Lengkap'),
                      subtitle: Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.email_outlined, color: Colors.blue),
                      title: const Text('Email'),
                      subtitle: Text(
                        email,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.phone_outlined, color: Colors.blue),
                      title: const Text('Nomor WhatsApp'),
                      subtitle: Text(
                        phone,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.wc_outlined, color: Colors.blue),
                      title: const Text('Jenis Kelamin'),
                      subtitle: Text(
                        gender,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Tombol Aksi Edit Profil
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Simulasi: Tombol Edit Profil ditekan'),
                    ),
                  );
                },
                child: const Text(
                  'EDIT PROFIL',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}