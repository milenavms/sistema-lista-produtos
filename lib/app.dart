import 'package:flutter/material.dart';
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
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ProductList(),
        '/details': (context) => const ProductDetails(),
      },
    );
  }
}
