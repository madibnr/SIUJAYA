import 'package:flutter/material.dart';
import 'package:siujaya/Login.dart';
import 'package:siujaya/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menonaktifkan Debug Banner
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,

        textTheme: const TextTheme(
          bodyText1: TextStyle(fontFamily: 'Poppins'),
          bodyText2: TextStyle(fontFamily: 'Poppins'),
          button: TextStyle(fontFamily: 'Poppins',  fontSize: 10.0, fontWeight: FontWeight.w600),
          headline1: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF5C42C4),
            height: 53.0 / 35.0,
            letterSpacing: 0.0,

          ),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/Images/bg.jpg'), // replace with your image path
            fit: BoxFit.cover,
          ),
        ),
    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sistem Informasi Unggul Jaya',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF5C42C4),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.fromLTRB(35.0, 15.0, 35.0, 15.0),
                    ),
                    child: const Text('Masuk'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: const Color(0xFF5C42C4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.fromLTRB(35.0, 15.0, 35.0, 15.0),
                    ),
                    child: const Text('Daftar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}