import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async'; // Tambahkan ini untuk penggunaan Timer
import 'package:kasirku/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Mengarahkan ke halaman LoginPage setelah 5 detik
    Timer(const Duration(seconds: 9), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff7CC974),
            Color(0xff3CAE30),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            height: 246,
            width: 293,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            'Kasirku',
            style: GoogleFonts.poppins(
              color: const Color(0xffFFFFFF),
              fontSize: 40,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ));
  }
}
