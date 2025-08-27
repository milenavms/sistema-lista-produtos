import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/domain/models/product.dart';
import 'package:projeto_lista_produtos/screens/components/info_row.dart';
import 'favorite_icon.dart';


class CustomCardProducts extends StatelessWidget {
  final Product product;

  const CustomCardProducts({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double imageWidth = kIsWeb ? 130 : 100;
    final double imageHeight = kIsWeb ? 121 : 90;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductImage(imageUrl: product.imageUrl, width: imageWidth, height: imageHeight),
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
  final double width;
  final double height;

  const _ProductImage({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.network(imageUrl, fit: BoxFit.cover),
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
        _ProductDescription(textDescription: product.description),
        const SizedBox(height: 4),
        _ProductDetailsRow(),
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
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
    );
  }
}

class _ProductDetailsRow extends StatelessWidget {
  const _ProductDetailsRow();

  @override
  Widget build(BuildContext context) {
    return InfoRow(
      text: "Entrega prevista para amanhã",
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
