import 'package:flutter/material.dart';
import '../../models/user_model.dart';

// Dashboard menerima data user yang login, supaya bisa ditampilkan
// namanya di header. Data ini dikirim dari login.dart pas navigasi.
class DashboardScreen extends StatelessWidget {
  final UserModel user;

  const DashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // Kembali ke halaman login, dan hapus semua history
              // navigasi sebelumnya supaya user nggak bisa "back" ke dashboard.
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kartu sapaan user
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selamat datang,',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          Text(
                            user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.email,
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Menu',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Grid menu utama - tinggal tambah/kurangi item sesuai kebutuhan app
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _MenuCard(
                    icon: Icons.assignment_outlined,
                    label: 'Survey',
                    color: Colors.blue,
                    onTap: () {
                      // TODO: arahkan ke halaman survey
                    },
                  ),
                  _MenuCard(
                    icon: Icons.history,
                    label: 'Riwayat',
                    color: Colors.orange,
                    onTap: () {
                      // TODO: arahkan ke halaman riwayat survey
                    },
                  ),
                  _MenuCard(
                    icon: Icons.person_outline,
                    label: 'Profile',
                    color: Colors.green,
                    onTap: () {
                      // TODO: arahkan ke halaman profile
                    },
                  ),
                  _MenuCard(
                    icon: Icons.settings_outlined,
                    label: 'Pengaturan',
                    color: Colors.purple,
                    onTap: () {
                      // TODO: arahkan ke halaman pengaturan
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget kecil khusus buat satu kartu menu, dipisah biar GridView di atas
// nggak terlalu panjang/berulang-ulang kodenya.
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}