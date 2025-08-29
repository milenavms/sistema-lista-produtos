import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_lista_produtos/screens/components/search_button.dart';

void main() {
  testWidgets('SearchButton updates ValueNotifier on input', (WidgetTester tester) async {

    final searchQuery = ValueNotifier<String>('');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchButton(searchQuery: searchQuery),
        ),
      ),
    );

    // Verifica se o TextField está presente
    expect(find.byType(TextField), findsOneWidget);


    await tester.enterText(find.byType(TextField), 'Teste Input');
    await tester.pumpAndSettle();

    // Verifica se o ValueNotifier foi atualizado
    expect(searchQuery.value, 'Teste Input');
  });
}
