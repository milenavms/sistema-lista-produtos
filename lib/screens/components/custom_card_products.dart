import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_button.dart';
import 'package:projeto_lista_produtos/screens/components/info_row.dart';

class CustomCardProducts extends StatelessWidget {
  final Product product;
  final bool isFavoriteVisibleIcon;

  const CustomCardProducts({super.key, required this.product, this.isFavoriteVisibleIcon = true});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
        border: Border(
          bottom: BorderSide(color: Color.fromARGB(255, 221, 220, 220), width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImage(imageUrl: product.image),
          const SizedBox(width: 12),
          Expanded(child: _ProductInfo(product: product, isFavorite: isFavoriteVisibleIcon)),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imageUrl;

   const ProductImage({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 90),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.broken_image,
              size: 40,
              color: Colors.grey,
            );
          },
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final Product product;
  final bool isFavorite;

  const _ProductInfo({required this.product, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProductDescription(textDescription: product.title),
        const SizedBox(height: 4),
        _ProductDetailsRowFavorite( 
          productId: product.id, 
          rate: product.rating.rate, 
          count: product.rating.count, 
          isFavoriteVisible: isFavorite
        ),
        const SizedBox(height: 6),
        _ProductPrice(price: product.price),
      ],
    );
  }
}

class _ProductDescription extends StatelessWidget {
  final String textDescription;
  const _ProductDescription({required this.textDescription});

  @override
  Widget build(BuildContext context) {
    return Text(
      textDescription,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
    );
  }
}

class _ProductDetailsRowFavorite extends StatelessWidget {
  final int productId;
  final double rate;
  final int count;
  final bool isFavoriteVisible;

  const _ProductDetailsRowFavorite({
    required this.productId,
    required this.rate,
    required this.count,
    this.isFavoriteVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return InfoRow(
      text: '$rate ($count reviews)',
      child: isFavoriteVisible
          ? FavoriteButton(productId: productId)
          : const SizedBox.shrink(),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  final double price;
  const _ProductPrice({required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$ ${price.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        color: Color(0xFFF37A20),
      ),
    );
  }
}

