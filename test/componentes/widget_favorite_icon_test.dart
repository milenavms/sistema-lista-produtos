import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_icon.dart';

void main() {
  testWidgets('FavoriteIcon chama assetImageBuilder se fornecido', (WidgetTester tester) async {
    bool builderCalled = false;

    ImageProvider<Object> builder(String path) {
      builderCalled = true;
      // Usa a imagem de teste dentro da pasta test
      return const AssetImage('test/image/img-teste.png');
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FavoriteIcon(
            isFavorite: false,
            onPressed: () {},
            assetImageBuilder: builder,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Confirma que o builder foi chamado
    expect(builderCalled, isTrue);

    // Confirma que existe um Image na árvore
    expect(find.byType(Image), findsOneWidget);
  });
}
