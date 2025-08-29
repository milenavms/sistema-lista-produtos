import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';

/// Filtra a lista de produtos pelo título.
/// 
/// [products] → lista completa de produtos
/// [query] → texto para buscar
/// [filteredNotifier] → ValueNotifier que será atualizado com os produtos filtrados
/// 
void filterProducts({
  required List<Product> products,
  required String query,
  required ValueNotifier<List<Product>> filteredNotifier,
}) {
  final filtered = products.where((p) {
    return p.title.toLowerCase().contains(query.toLowerCase());
  }).toList();

  filteredNotifier.value = filtered;
}
