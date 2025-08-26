import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductDetails'),
      ),
      body: const Center(
        child: Text(
          'ProductDetails Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
