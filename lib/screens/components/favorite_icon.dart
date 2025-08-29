import 'package:flutter/material.dart';

class FavoriteIcon extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onPressed;
  final ImageProvider<Object> Function(String path)? assetImageBuilder;

  const FavoriteIcon({
    super.key,
    required this.isFavorite,
    this.onPressed,
    this.assetImageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Image(
        image: assetImageBuilder?.call(
              isFavorite
                  ? 'assets/favorite.png'
                  : 'assets/favorite-border.png',
            ) ??
            AssetImage(
              isFavorite
                  ? 'assets/favorite.png'
                  : 'assets/favorite-border.png',
            ),
        width: 24,
        height: 24,
      ),
    );
  }
}
