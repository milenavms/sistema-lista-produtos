import 'package:flutter/material.dart';
import 'screens/products/product_favorites.dart';
import 'screens/products/product_list.dart';
import 'screens/products/product_details.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produtos App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductList(),
      routes: {
        '/favorites': (context) => ProductFavorites(),
        '/details': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          final int productId = args['id'];
          return ProductDetails(productId: productId);
        },
      },
    );
  }
}
