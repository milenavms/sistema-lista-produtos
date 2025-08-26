import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/screens/components/custom_app_bar.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_icon.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

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
        iconWidget:  FavoriteIcon(
          isFavorite: false,
          onPressed: () {
            print('Coração clicado');
          }, // TODO: implementar ação
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Product $index'),
            subtitle: Text('Description of product $index'),
          );
        },
      ),
    );
  }
}
