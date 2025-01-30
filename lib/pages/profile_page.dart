import 'package:flutter/material.dart';
import 'package:kasirku/pages/login_page.dart';
import 'package:kasirku/pages/cart_page.dart';
import 'package:kasirku/pages/home_page.dart';
import 'package:kasirku/pages/product_page.dart';
import 'package:kasirku/pages/history_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar image
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage(
                  'assets/avatar.png'), // Ganti dengan path image Anda
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 20),

            // Nama usaha
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nama usaha',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Alamat
            const TextField(
              decoration: InputDecoration(
                labelText: 'Alamat',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // No. Telepon
            const TextField(
              decoration: InputDecoration(
                labelText: 'no.telepon',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Logout button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  'logout',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Produk'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.green,
        currentIndex: 4,
        onTap: (index) {
          switch (index) {
            case 0:
              // Beranda icon index
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              break;
            case 1:
              // Keranjang icon index
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const CartPage(
                          cartItems: [],
                        )),
              );
              break;
            case 2:
              // Produk icon index
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProductPage()),
              );
              break;
            case 3:
              // Riwayat icon index
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
              break;
            case 4:
              // Profile icon index
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
              break;
          }
        },
      ),
    );
  }
}
