import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';
import 'package:projeto_lista_produtos/screens/components/custom_card_products.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_button.dart';


void main() {

  final product = Product(
    id: 1,
    title: 'Produto Teste',
    price: 99.99,
    description: 'Descrição do produto teste',
    category: 'Categoria',
    image: 'fake_image',
    rating: Rating(rate: 4.5, count: 10),
  );

  // Substituir ProductImage para usar MemoryImage durante os testes
  Widget testableProductCard(Product product, {bool isFavoriteVisible = true}) {
    return MaterialApp(
      home: Scaffold(
        body: CustomCardProducts(
          product: product,
          isFavoriteVisibleIcon: isFavoriteVisible,
        ),
      ),
    );
  }

  testWidgets('CustomCardProducts deve renderizar corretamente', (WidgetTester tester) async {
    debugPrint('Rodando teste CustomCardProducts 01');

    await tester.pumpWidget(testableProductCard(product));

    // Verifica se o widget ProductImage está presente
    expect(find.byType(ProductImage), findsOneWidget);

    // Verifica se a descrição aparece
    expect(find.text('Produto Teste'), findsOneWidget);

    // Verifica se o preço aparece
    expect(find.text('\$ 99.99'), findsOneWidget);

    // Verifica se o botão de favorito aparece
    expect(find.byType(FavoriteButton), findsOneWidget);

    // Verifica se o InfoRow (texto de rating) aparece
    expect(find.text('4.5 (10 reviews)'), findsOneWidget);
  });

  testWidgets('CustomCardProducts oculta o botão favorito quando isFavoriteVisibleIcon é falso', (WidgetTester tester) async {
    debugPrint('Rodando teste CustomCardProducts 02');

    await tester.pumpWidget(testableProductCard(product, isFavoriteVisible: false));

    // Botão de favorito não deve estar presente
    expect(find.byType(FavoriteButton), findsNothing);

    // Descrição e preço ainda aparecem
    expect(find.text('Produto Teste'), findsOneWidget);
    expect(find.text('\$ 99.99'), findsOneWidget);

    // _ProductImage ainda presente
    expect(find.byType(ProductImage), findsOneWidget);
  });
}
