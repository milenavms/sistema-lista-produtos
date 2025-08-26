import 'package:flutter/material.dart';

class FavoriteIcon extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onPressed;

  const FavoriteIcon({
    super.key,
    required this.isFavorite,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(
        isFavorite
            ? 'assets/favorite.png'
            : 'assets/favorite-border.png',       
        width: 24,
        height: 24,
      ),
    );
  }
}
