import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_lista_produtos/screens/components/custom_app_bar.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_icon.dart';

void main() {
  testWidgets('Deve renderizar o CustomAppBar com título e ícone', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: CustomAppBar(
            title: 'Products',
            iconWidget: FavoriteIcon(
              isFavorite: false,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Products'), findsOneWidget);
    expect(find.byType(FavoriteIcon), findsOneWidget);
  });
}
