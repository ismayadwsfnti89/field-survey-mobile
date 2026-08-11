import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var text = const Text("Ismaya dewi sofianti",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      );
    return Scaffold(
      body: 
      const CircleAvatar(
        radius: 50,
        child: Icon(Icons.person, size: 50),

      )
    );
  }
}