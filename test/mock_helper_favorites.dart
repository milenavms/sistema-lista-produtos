
import 'package:projeto_lista_produtos/controllers/favorites_helper.dart';

typedef ToggleCallback = void Function();

// Fake que implementa a mesma interface de FavoritesHelper
class FavoriteProductHelper implements FavoritesHelper {
  final ToggleCallback? onToggle;
  final Set<int> _favorites = {};

  FavoriteProductHelper({this.onToggle});

  // Sobrescreve getFavorites
  @override
  Future<List<int>> getFavorites() async {
    return _favorites.toList();
  }

  // Sobrescreve toggleFavorite
  @override
  Future<void> toggleFavorite(int productId) async {
    if (_favorites.contains(productId)) {
      _favorites.remove(productId);
    } else {
      _favorites.add(productId);
    }

    // Chama callback para teste
    if (onToggle != null) {
      onToggle!();
    }
  }
}

// Função helper para criar o fake
FavoriteProductHelper createFakeProduct({ToggleCallback? onToggle}) {
  return FavoriteProductHelper(onToggle: onToggle);
}
