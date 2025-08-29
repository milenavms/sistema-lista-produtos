import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_button.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_icon.dart';
import 'package:projeto_lista_produtos/controllers/favorites_controler.dart';

import '../mock_helper_favorites.dart';

void main() {
  setUp(() {
    // Limpa os favoritos antes de cada teste
    FavoritesController.favoriteIdsNotifier.value = <int>{};
  });

  testWidgets('FavoriteButton exibe FavoriteIcon corretamente', (WidgetTester tester) async {
    debugPrint('Rodando teste FavoriteButton 01');
    const productId = 1;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FavoriteButton(productId: productId),
        ),
      ),
    );

    // Inicialmente não está favoritado
    final icon = tester.widget<FavoriteIcon>(find.byType(FavoriteIcon));
    expect(icon.isFavorite, isFalse);
  });

  testWidgets('FavoriteButton chama toggleFavorite ao clicar', (WidgetTester tester) async {
    debugPrint('Rodando teste FavoriteButton 02');

    const productId = 1;
    bool toggled = false;

    final fakeHelper = createFakeProduct(onToggle: () => toggled = true);
    FavoritesController.helper = fakeHelper;
    FavoritesController.favoriteIdsNotifier.value = {};

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FavoriteButton(productId: productId),
        ),
      ),
    );

    await tester.tap(find.byType(FavoriteIcon));
    await tester.pumpAndSettle();

    expect(toggled, isTrue);

    final icon = tester.widget<FavoriteIcon>(find.byType(FavoriteIcon));
    expect(icon.isFavorite, isTrue);
  });

}
