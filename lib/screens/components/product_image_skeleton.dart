import 'package:flutter/material.dart';

class ProductImageSkeleton extends StatelessWidget {
  final String imageUrl;
  final double maxWidth;

  const ProductImageSkeleton({
    required this.imageUrl,
    this.maxWidth = 90,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            // Skeleton enquanto carrega
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
          },
        ),
      ),
    );
  }
}
