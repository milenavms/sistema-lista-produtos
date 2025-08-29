import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/controllers/api_controller.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';
import 'package:projeto_lista_produtos/screens/components/custom_app_bar.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_button.dart';
import 'package:projeto_lista_produtos/screens/components/info_row.dart';

class ProductDetails extends StatelessWidget {
  final int? productId;
  final ApiController? apiController;
  final ImageProvider Function(String path)? assetImageBuilder;

  const ProductDetails({
    super.key, 
    required this.productId, 
    this.apiController, 
    this.assetImageBuilder,
  });


  @override
  Widget build(BuildContext context) {
    if (productId == null) return _buildScaffoldWithError();

    final controller = apiController ?? ApiController(); 

    return FutureBuilder<Product>(
      future:  controller.fetchProductById(productId!),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildScaffoldWithLoading();
        } else if (snapshot.hasError || !snapshot.hasData) {
          return _buildScaffoldWithError();
        }

        final product = snapshot.data!;

        return Scaffold(
          appBar: CustomAppBar(
            showBackButton: true,
            roteGoBack: "/",
            title: 'Product Details',
            iconWidget: FavoriteButton(productId: product.id),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: kIsWeb ? Colors.grey[200] : Colors.white,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
                    minWidth: kIsWeb ? 800 : MediaQuery.of(context).size.width * 0.8,
                    maxWidth: kIsWeb ? 800 : double.infinity,
                  ),
                  child: ProductDetailsContent(product: product, assetImageBuilder: assetImageBuilder,),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScaffoldWithLoading() => Scaffold(
        appBar: CustomAppBar(
          showBackButton: true,
          roteGoBack: "/",
          title: 'Product Details',
        ),
        backgroundColor: Colors.white,
        body: const Center(child: CircularProgressIndicator()),
      );

  Widget _buildScaffoldWithError() => Scaffold(
        appBar: CustomAppBar(
          showBackButton: true,
          roteGoBack: "/",
          title: 'Product Details',
        ),
        body: Center(child: ErrorMessage( 
          assetImageBuilder: (path) => const AssetImage(''), 
          )),
      );
}


class ProductDetailsContent extends StatelessWidget {
  final Product product;
  final ImageProvider Function(String path)? assetImageBuilder;

  const ProductDetailsContent({super.key, required this.product, this.assetImageBuilder});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kIsWeb ? 16 : 0),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 310),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Exibe ícone de erro se a imagem não carregar
                    return const Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            ProductTitle(product.title),

            const SizedBox(height: 16),
            ProductRatingPrice(
              rate: product.rating.rate,
              count: product.rating.count,
              price: product.price,
            ),

            const SizedBox(height: 30),
            IconWithDescription(
              img: assetImageBuilder?.call('assets/query_builder-left.png') 
                  ?? const AssetImage('assets/query_builder-left.png'),
              description: product.category,
            ),

            const SizedBox(height: 16),
            IconWithDescription(
               img: assetImageBuilder?.call('assets/query_builder-justify.png') 
                  ?? const AssetImage('assets/query_builder-justify.png'),
              description: product.description,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  final String title;
  const ProductTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class ProductRatingPrice extends StatelessWidget {
  final double rate;
  final int count;
  final double price;
  const ProductRatingPrice({super.key, required this.rate, required this.count, required this.price});

  @override
  Widget build(BuildContext context) {
    return InfoRow(
      text: '$rate ($count reviews)',
      child: Text(
        '\$ ${price.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 29,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
          color: Color(0xFF5EC401),
        ),
      ),
    );
  }
}

class IconWithDescription extends StatelessWidget {
  final ImageProvider img;
  final String description;
  const IconWithDescription({super.key, required this.img, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: img, width: 24, height: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class ErrorMessage extends StatelessWidget {
  final ImageProvider Function(String path)? assetImageBuilder;

  const ErrorMessage({super.key, this.assetImageBuilder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image( 
            image: assetImageBuilder?.call('assets/error.png') ?? const AssetImage('assets/error.png'),
            width: 200,
            height: 200,),
          const SizedBox(height: 16),
          const Text(
            'Something went wrong!',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xA637474F),
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
