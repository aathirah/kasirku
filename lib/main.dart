import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kasirku/pages/history_page.dart';
import 'package:kasirku/pages/payment_page.dart';
import 'package:kasirku/pages/product_page.dart';
import 'package:kasirku/pages/profile_page.dart';
import 'package:kasirku/pages/splash_page.dart';
import 'package:kasirku/pages/login_page.dart';
import 'package:kasirku/pages/signup_page.dart';
import 'package:kasirku/pages/home_page.dart';
import 'package:kasirku/pages/cart_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase di sini
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/cart': (context) => const CartPage(
              cartItems: [],
            ),
        '/product': (context) => const ProductPage(),
        '/history': (context) => const HistoryPage(),
        '/profile': (context) => const ProfilePage(),
        '/payment': (context) => const PaymentPage(),
      },
    );
  }
}
