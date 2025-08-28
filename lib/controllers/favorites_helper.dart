import 'package:shared_preferences/shared_preferences.dart';

class FavoritesHelper {
  static const String _keyFavorites = 'favorites';

  static Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_keyFavorites) ?? [];
    return data.map(int.parse).toList();
  }

  static Future<void> toggleFavorite(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    if (favorites.contains(productId)) {
      favorites.remove(productId);
    } else {
      favorites.add(productId);
    }

    await prefs.setStringList(
      _keyFavorites,
      favorites.map((e) => e.toString()).toList(),
    );
  }
}
