import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_lista_produtos/domain/models/product.dart';
import 'package:projeto_lista_produtos/screens/components/custom_app_bar.dart';
import 'package:projeto_lista_produtos/screens/components/custom_card_products.dart';
import 'package:flutter/foundation.dart';

class ProductFavorites extends StatefulWidget {
  ProductFavorites({super.key});

  final List<Product> products = [
    Product(
      id: 1,
      description: 'Produto 1',
      price: 10.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  @override
  _ProductFavoritesState createState() => _ProductFavoritesState();
}

class _ProductFavoritesState extends State<ProductFavorites> {

   final double marginTop = kIsWeb ? 16.0 : 0.0;
   final double marginBottom = kIsWeb ? 20.0 : 0.0;
   final double navbarHeight = kToolbarHeight; // default AppBar height
   bool get hasProducts => widget.products.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favorites'
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.grey[200],
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                ConstrainedBox( 
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - navbarHeight - marginTop - marginBottom - 20,
                    maxWidth: kIsWeb ? 800 : double.infinity,
                  ),
                  child: hasProducts
                    ? Align( 
                        alignment: Alignment.topCenter,
                        child: _buildProductList(widget.products),
                      )
                    : Center(
                        child: _buildErrorMessage(),
                      ),
                ),
                ], 
              )
            ),
          ),
        ),
      ),
    ); 
  }

  Widget _buildProductList(List<Product> products) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: products.map((product) {
          return InkWell(
            onTap: () {
              context.go('/details/${product.id}');
            },
            child: CustomCardProducts(product: product),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/error_search.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 16),
          Text(
            'The list is empty',
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xA637474F),
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


