import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siujaya/home.dart';
import 'package:siujaya/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String getEmailFromTextField() {
    return _emailController.text;
  }

  String getPasswordFromTextField() {
    return _passwordController.text;
  }
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/Images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
       Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF5C42C4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Silahkan Masuk Menggunakan akun yang sudah terdaftar',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                style: const TextStyle(fontSize: 12),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'NPM / Email',
                  filled: true,
                  fillColor: const Color(0xFFF1F4FF),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 16),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Color(0xFF5C42C4), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                style: const TextStyle(fontSize: 12),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color(0xFFF1F4FF),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 16),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Color(0xFF5C42C4), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Lupa Password?',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF5C42C4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    String email = getEmailFromTextField();
                    String password = getPasswordFromTextField();

                    UserCredential userCredential =
                    await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (userCredential.user != null) {
                      // Pengguna berhasil login, sekarang dapat mengambil data pengguna dari Firestore
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage()
                        ),
                      );
                    }
                  } catch (e) {
                    print("Login error: $e");
                    showSnackBar("Login failed. Please check your credentials.");
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF5C42C4)),
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.transparent, width: 10),
                    ),
                  ),
                ),
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'Buat Akun Baru',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF5C42C4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '(Untuk Mahasiswa Tamu dan Mitra)',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
       ),
        ],
      ),
    );
  }
}
