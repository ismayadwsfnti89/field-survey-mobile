import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class DashboardPage extends StatelessWidget {
  final UserModel user;

  const DashboardPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FIELD SURVEY"),
      ),

      // DRAWER
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "FIELD SURVEY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // HOME
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // SURVEY
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text("Survey"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // PROFILE
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // ISI DASHBOARD
      body: Center(
        child: Text(
          "Selamat datang, ${user.name}",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}