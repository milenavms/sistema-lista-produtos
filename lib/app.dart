import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
