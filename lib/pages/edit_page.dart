import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasirku/pages/product_page.dart';

class EditPage extends StatefulWidget {
  final String productId;
  final String initialName;
  final double initialPrice;
  final String
      initialCategory; // Mengganti initialDescription menjadi initialCategory
  final String initialImageUrl;

  const EditPage({
    super.key,
    required this.productId,
    required this.initialName,
    required this.initialPrice,
    required this.initialCategory,
    required this.initialImageUrl,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;

  String? _selectedCategory; // Kategori yang dipilih
  final List<String> _categories = ['T-shirt', 'Pants', 'Shoes', 'All'];

  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _priceController =
        TextEditingController(text: widget.initialPrice.toString());
    _imageUrlController = TextEditingController(text: widget.initialImageUrl);
    _selectedCategory = widget.initialCategory; // Mengatur kategori awal
  }

  Future<void> _updateProduct() async {
    final String name = _nameController.text.trim();
    final String price = _priceController.text.trim();
    final String imageUrl = _imageUrlController.text.trim();

    if (name.isEmpty ||
        price.isEmpty ||
        imageUrl.isEmpty ||
        _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua bidang harus diisi!')),
      );
      return;
    }

    try {
      await _productsCollection.doc(widget.productId).update({
        'name': name,
        'price': double.parse(price),
        'category': _selectedCategory,
        'imageUrl': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk berhasil diperbarui!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProductPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui produk: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Edit Produk',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama produk',
                hintText: 'Blue jeans',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Harga produk',
                hintText: '89000',
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Dropdown Kategori Produk
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: UnderlineInputBorder(),
              ),
              items: _categories
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              hint: const Text('Pilih kategori produk'),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Gambar URL',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updateProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
