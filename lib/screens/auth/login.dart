import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_appl_latihan/screens/dashboard1.dart';
import 'package:flutter_appl_latihan/screens/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool obscurePassword = true;

  // LOGIN REST API
  // ==========================================
  Future<void> login() async {
    // Validasi form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // ==========================================
      // REQUEST KE REST API
      final response = await http.post(
        Uri.parse('https://sijala.biz.id/api/v1/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': emailController.text.trim(),
          'password': passwordController.text,
        }),
      );

      // ==========================================
      // RESPONSE JSON
      final data = jsonDecode(response.body);

      // LOGIN BERHASIL
      // ==========================================
      if (response.statusCode == 200) {
        final token = data['token'];

        if (token == null) {
          throw Exception('Token tidak ditemukan.');
        }

        // SIMPAN TOKEN
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'token',
          token.toString(),
        );

        // SIMPAN DATA USER
        if (data['user'] != null) {
          await prefs.setString(
            'user',
            jsonEncode(data['user']),
          );
        }

        if (!mounted) return;

        // PESAN LOGIN BERHASIL
        // ==========================================
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil'),
            backgroundColor: Colors.green,
          ),
        );

        // MASUK DASHBOARD
        // ==========================================
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ),
        );
      }
      // LOGIN GAGAL
      // ==========================================
      else {
        final message = data['message'] ?? 'Email atau password salah.';
        throw Exception(message);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst(
                  'Exception: ',
                  '',
                ),
          ),
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.add_box,
                    size: 90,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'FIELD SURVEY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Selamat Datang!',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // EMAIL
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
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
                  const SizedBox(height: 16),
                  // PASSWORD
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // LOGIN BUTTON
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : login,
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
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // REGISTER
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Belum punya akun? Daftar',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}