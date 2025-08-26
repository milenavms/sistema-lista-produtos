import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/screens/components/custom_app_bar.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_icon.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Product Details', 
        iconWidget:  FavoriteIcon(
          isFavorite: true,
        ),
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
