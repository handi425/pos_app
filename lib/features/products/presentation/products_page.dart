import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produk & Kategori')),
      body: const Center(child: Text('Daftar produk dan manajemen stok.')),
    );
  }
}
