import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // FORM & CONTROLLER
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String? gender;
  bool isLoading = false;

  // DISPOSE
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // REUSABLE TEXT FIELD WIDGET
  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  // REGISTER FUNCTION
  Future<void> register() async {
    // 1. Validasi form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 2. Validasi dropdown gender
    if (gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih jenis kelamin.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // 3. Request POST ke REST API
      final response = await http.post(
        Uri.parse('https://sijala.biz.id/api/v1/register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': nameController.text.trim(),
          'gender': gender,
          'email': emailController.text.trim(),
          'phone': phoneController.text.trim(),
        }),
      );

      // 4. Response JSON Decode
      final data = jsonDecode(response.body);

      // 5. Cek respon sukses
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['status'] == true) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message'] ?? 'Registrasi berhasil.'),
              backgroundColor: Colors.green,
            ),
          );
          // Kembali ke halaman Login
          Navigator.pop(context);
        } else {
          throw Exception(data['message'] ?? 'Registrasi gagal.');
        }
      } else {
        final message = data['message'] ?? 'Registrasi gagal.';
        throw Exception(message);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_add,
                  size: 90,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Daftar Akun',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Silakan lengkapi data diri Anda',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // NAMA
                buildTextField(
                  controller: nameController,
                  label: 'Nama Lengkap',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                ),

                // JENIS KELAMIN
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: DropdownButtonFormField<String>(
                    value: gender,
                    decoration: const InputDecoration(
                      labelText: 'Jenis Kelamin',
                      prefixIcon: Icon(Icons.wc),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'L',
                        child: Text('Laki-laki'),
                      ),
                      DropdownMenuItem(
                        value: 'P',
                        child: Text('Perempuan'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Jenis kelamin wajib dipilih';
                      }
                      return null;
                    },
                  ),
                ),

                // EMAIL
                buildTextField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email wajib diisi';
                    }
                    if (!value.contains('@')) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),

                // NOMOR WHATSAPP
                buildTextField(
                  controller: phoneController,
                  label: 'Nomor WhatsApp',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nomor WhatsApp wajib diisi';
                    }
                    if (value.trim().length < 10) {
                      return 'Nomor WhatsApp minimal 10 digit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // BUTTON REGISTER
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : register,
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Daftar Sekarang',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}