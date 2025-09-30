import 'package:flutter/material.dart';

class DebtsPage extends StatelessWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kasbon')),
      body: const Center(child: Text('Daftar kasbon dan pembayaran.')),
    );
  }
}
