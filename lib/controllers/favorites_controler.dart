import 'package:flutter/foundation.dart';
import 'package:projeto_lista_produtos/controllers/favorites_helper.dart';


class FavoritesController {
  // Notificador global para IDs favoritados
  static ValueNotifier<Set<int>> favoriteIdsNotifier = ValueNotifier({});

  // Inicializa o ValueNotifier com os dados salvos
  static Future<void> loadFavorites() async {
    final ids = await FavoritesHelper.getFavorites();
    favoriteIdsNotifier.value = ids.toSet();
  }

  // Alterna favorito e atualiza o ValueNotifier
  static Future<void> toggleFavorite(int productId) async {
    await FavoritesHelper.toggleFavorite(productId);
    final ids = await FavoritesHelper.getFavorites();
    favoriteIdsNotifier.value = ids.toSet();
  }
  
  // Verifica se um produto está favoritado
  static bool isFavorite(int productId) {
    return favoriteIdsNotifier.value.contains(productId);
  }
}
