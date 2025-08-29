import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_button.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_icon.dart';
import 'package:projeto_lista_produtos/controllers/favorites_controler.dart';

void main() {
  setUp(() {
    // Reseta os favoritos antes de cada teste
    FavoritesController.favoriteIdsNotifier.value = {};
  });

  testWidgets('FavoriteButton exibe FavoriteIcon corretamente', (WidgetTester tester) async {
    const productId = 1;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FavoriteButton(productId: productId),
        ),
      ),
    );

    expect(find.byType(FavoriteIcon), findsOneWidget);

    final icon = tester.widget<FavoriteIcon>(find.byType(FavoriteIcon));
    expect(icon.isFavorite, isFalse);
  });

  testWidgets('FavoriteButton alterna favorito ao clicar', (WidgetTester tester) async {
    const productId = 1;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FavoriteButton(productId: productId),
        ),
      ),
    );

    // Inicialmente não está favoritado
    var icon = tester.widget<FavoriteIcon>(find.byType(FavoriteIcon));
    expect(icon.isFavorite, isFalse);

    // Adiciona ao ValueNotifier simulando toggle
    FavoritesController.favoriteIdsNotifier.value = {productId};
    await tester.pumpAndSettle();

    icon = tester.widget<FavoriteIcon>(find.byType(FavoriteIcon));
    expect(icon.isFavorite, isTrue);

    // Remove do ValueNotifier simulando toggle
    FavoritesController.favoriteIdsNotifier.value = {};
    await tester.pumpAndSettle();

    icon = tester.widget<FavoriteIcon>(find.byType(FavoriteIcon));
    expect(icon.isFavorite, isFalse);
  });
}
