import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_lista_produtos/screens/components/info_row.dart';

void main() {
  testWidgets('InfoRow renderiza texto, imagem e child corretamente', (WidgetTester tester) async {
    debugPrint('Rodando teste InfoRow 01');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InfoRow(
            text: 'Texto de teste',
            child: const Icon(Icons.check),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(); // espera renderização completa

    // Verifica se a imagem padrão está presente
    expect(find.byType(Image), findsOneWidget);

    // Verifica se o texto está presente
    expect(find.text('Texto de teste'), findsOneWidget);

    // Verifica se o child está presente
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

}
