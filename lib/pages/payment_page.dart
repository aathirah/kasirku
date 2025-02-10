import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'success_page.dart';

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final int totalPrice;

  const PaymentPage(
      {super.key, required this.cartItems, required this.totalPrice});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedMethod = 'Tunai'; // Default metode pembayaran

  Future<void> _processPayment() async {
    if (widget.cartItems.isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('transactions').add({
        'items': widget.cartItems,
        'total': widget.totalPrice,
        'paymentMethod': selectedMethod,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memproses pembayaran: $e')),
      );
    }
  }

  void _showQrisDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "QRIS Payment",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Scan QR code below to pay:",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              Image.asset(
                'assets/qris.png', // Pastikan gambar ini ada di folder assets
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.purple, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Metode Pembayaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _paymentMethodButton('Tunai'),
                _paymentMethodButton('Qris'),
              ],
            ),
            const SizedBox(height: 16),

            // Jika metode pembayaran adalah QRIS, tampilkan tombol untuk membuka dialog
            if (selectedMethod == 'Qris')
              Center(
                child: ElevatedButton(
                  onPressed: _showQrisDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    'Tampilkan QRIS',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            _summaryRow('Sub total',
                'Rp ${NumberFormat("#,###", "id_ID").format(widget.totalPrice)}'),
            _summaryRow('Tax (10%)',
                'Rp ${NumberFormat("#,###", "id_ID").format((widget.totalPrice * 0.1).toInt())}'),
            const Divider(),
            _summaryRow('Total',
                'Rp ${NumberFormat("#,###", "id_ID").format((widget.totalPrice * 1.1).toInt())}',
                isBold: true),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Bayar',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethodButton(String method) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedMethod = method);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color:
                selectedMethod == method ? Colors.green : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(method,
                style: TextStyle(
                    color:
                        selectedMethod == method ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}
