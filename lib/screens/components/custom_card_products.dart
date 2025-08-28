import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';
import 'package:projeto_lista_produtos/screens/components/info_row.dart';
import 'package:projeto_lista_produtos/screens/components/product_image_skeleton.dart';
import 'favorite_icon.dart';


class CustomCardProducts extends StatelessWidget {
  final Product product;

  const CustomCardProducts({super.key, required this.product});

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
          _ProductImage(imageUrl: product.image),
          const SizedBox(width: 12),
          Expanded(child: _ProductInfo(product: product)),
        ],
      ),
    );
  }
}

// Imagem do produto
class _ProductImage extends StatelessWidget {
  final String imageUrl;

  const _ProductImage({
    required this.imageUrl,
     Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductImageSkeleton(
      imageUrl: imageUrl,
      maxWidth: 90,
    );
  }
}

// Informações do produto
class _ProductInfo extends StatelessWidget {
  final Product product;

  const _ProductInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProductDescription(textDescription: product.title),
        const SizedBox(height: 4),
        _ProductDetailsRow( rate: product.rating.rate, count: product.rating.count),
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

class _ProductDetailsRow extends StatelessWidget {
  final double rate;
  final int count;  
  const _ProductDetailsRow({required this.rate, required this.count});

  @override
  Widget build(BuildContext context) {
    return InfoRow(
      text: '$rate ($count reviews)',
      child: FavoriteIcon(
           isFavorite: false,
           onPressed: () => print('Coração clicado'), //TODO: implementar ação
         )
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
