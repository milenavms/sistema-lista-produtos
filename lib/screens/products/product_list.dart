import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/screens/components/custom_app_bar.dart';
import 'package:projeto_lista_produtos/screens/components/custom_card_products.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_icon.dart';
import 'package:flutter/foundation.dart';

class ProductList extends StatefulWidget {
  ProductList({super.key});

  final List<Product> products = [
    Product(
      description: 'Produto 1',
      price: 10.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      description: 'Produto 2',
      price: 25.50,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      description: 'Produto 3',
      price: 12.75,
      imageUrl: 'https://via.placeholder.com/150',
    ),
        Product(
      description: 'Produto 4',
      price: 25.50,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      description: 'Produto 5',
      price: 12.75,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  @override
  void initState() {
    super.initState();
    // chama a API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Products',
        iconWidget: FavoriteIcon(
          isFavorite: false,
          onPressed: () {
            print('Coração clicado');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.grey[200],
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 400,
                maxWidth: kIsWeb ? 800 : double.infinity,
              ),
              child: _buildProductList(widget.products),
            ),
          ),
        ),
      ),
    ); 
  }
}


Widget _buildProductList(List<Product> products) {
  final double marginTop = kIsWeb ? 16.0 : 0.0;
  final double marginBottom = kIsWeb ? 20.0 : 0.0;

  return Container(
    margin:  EdgeInsets.only(top: marginTop, bottom: marginBottom),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: products
          .map((product) => CustomCardProducts(product: product))
          .toList(),
    ),
  );
}
