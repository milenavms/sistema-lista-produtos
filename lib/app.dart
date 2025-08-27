import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_lista_produtos/screens/products/product_favorites.dart';
import 'screens/products/product_list.dart';
import 'screens/products/product_details.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ProductList(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id']!);
        return ProductDetails(productId: id);
      },
    ),
      GoRoute(
      path: '/favorites',
      builder: (context, state) => ProductFavorites(),
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Produtos App',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
