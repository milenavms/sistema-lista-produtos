import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/controllers/favorites_controler.dart';
import 'favorite_icon.dart';

class FavoriteButton extends StatelessWidget {
  final int productId;

  const FavoriteButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<int>>(
      valueListenable: FavoritesController.favoriteIdsNotifier,
      builder: (context, favoriteIds, _) {
        final isFavorite = favoriteIds.contains(productId);
        return FavoriteIcon(
          isFavorite: isFavorite,
          onPressed: () async {
            await FavoritesController.toggleFavorite(productId);
          },
        );
      },
    );
  }
}
