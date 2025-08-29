import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';
import 'package:projeto_lista_produtos/utils/product_filter.dart';

//Testa funcao filterProducts.dart

void main() {
  late List<Product> allProducts;
  late ValueNotifier<List<Product>> filteredNotifier;

  setUp(() {
    allProducts = [
      Product(
        id: 1,
        title: 'Apple iPhone',
        price: 999.99,
        description: 'Smartphone Apple',
        category: 'Eletrônicos',
        image: 'apple.png',
        rating: Rating(rate: 4.5, count: 100),
      ),
      Product(
        id: 2,
        title: 'Samsung Galaxy',
        price: 899.99,
        description: 'Smartphone Samsung',
        category: 'Eletrônicos',
        image: 'samsung.png',
        rating: Rating(rate: 4.3, count: 50),
      ),
      Product(
        id: 3,
        title: 'Banana',
        price: 2.99,
        description: 'Fruta amarela',
        category: 'Alimentos',
        image: 'banana.png',
        rating: Rating(rate: 4.8, count: 200),
      ),
    ];

    filteredNotifier = ValueNotifier<List<Product>>([]);
  });

  test('Filtro retorna produtos que contêm a query', () {
    debugPrint('Iniciando teste: Filtro 01');
    filterProducts(products: allProducts, query: 'apple', filteredNotifier: filteredNotifier);

    expect(filteredNotifier.value.length, 1);
    expect(filteredNotifier.value.first.title, 'Apple iPhone');
  });

  test('Filtro retorna lista vazia se nenhum produto corresponder', () {
     debugPrint('Iniciando teste: Filtro 2');
    filterProducts(products: allProducts, query: 'xyz', filteredNotifier: filteredNotifier);

    expect(filteredNotifier.value.length, 0);
  });

  test('Filtro é case-insensitive', () {
    debugPrint('Iniciando teste: Filtro 3');
    filterProducts(products: allProducts, query: 'samsung', filteredNotifier: filteredNotifier);

    expect(filteredNotifier.value.length, 1);
    expect(filteredNotifier.value.first.title, 'Samsung Galaxy');
  });

  test('Filtro retorna todos os produtos se a query for vazia', () {
    debugPrint('Iniciando teste: Filtro 4');
    filterProducts(products: allProducts, query: '', filteredNotifier: filteredNotifier);

    expect(filteredNotifier.value.length, 3);
  });
}
