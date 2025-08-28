import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/controllers/api_controller.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';
import 'package:projeto_lista_produtos/screens/components/custom_app_bar.dart';
import 'package:projeto_lista_produtos/screens/components/info_row.dart';
import 'package:projeto_lista_produtos/screens/components/product_image_skeleton.dart';

class ProductDetails extends StatelessWidget {
  final int? productId;
  final ApiController _apiController = ApiController();

  ProductDetails({super.key,required this.productId});

  @override
  Widget build(BuildContext context) {

   
    if (productId == null) {
      return Scaffold(
        appBar: CustomAppBar(
          showBackButton: true,
          roteGoBack: "/",
          title: 'Product Details',
        ),
        body: Center(child: _buildErrorMessage()),
      );
    }
    
    // Buscar produto pela API
    return FutureBuilder<Product>(
      future: _apiController.fetchProductById(productId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Enquanto carrega
          return Scaffold(
            appBar: CustomAppBar(
              showBackButton: true,
              roteGoBack: "/",
              title: 'Product Details',
            ),
            backgroundColor: Colors.white,
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          // Se der erro
          return Scaffold(
            appBar: CustomAppBar(
              showBackButton: true,
              roteGoBack: "/",
              title: 'Product Details',
            ),
            body: Center(child: _buildErrorMessage()),
          );
        } else if (!snapshot.hasData) {
          // Se não retornar produto
          return Scaffold(
            appBar: CustomAppBar(
              showBackButton: true,
              roteGoBack: "/",
              title: 'Product Details',
            ),
            body: Center(child: _buildErrorMessage()),
          );
        }

      
        final product = snapshot.data!;

        return Scaffold(
          appBar: CustomAppBar(
            showBackButton: true,
            roteGoBack: "/",
            title: 'Product Details',
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
                  child: _buildProductDetails(product),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductDetails(Product product) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
         
        children: [
          ProductImageSkeleton(
            imageUrl: product.image,
            maxWidth: 310,
          ),

          const SizedBox(height: 16),

          SizedBox(
            child: Text(
              product.title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500
              ),    
            ),
          ),

          const SizedBox(height: 8),
         
          InfoRow(
            text: '${product.rating.rate} (${product.rating.count} reviews)',
            child:  Text(
              '\$ ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Color(0xFF5EC401)),
              ),
          ),
          
          const SizedBox(height: 16),

          _buildIconAndDescription(img: 'assets/query_builder-left.png', description: product.category),

          const SizedBox(height: 16),

          _buildIconAndDescription(img: 'assets/query_builder-justify.png', description: product.description),

        ],
      ),
    );
    }

  Widget _buildErrorMessage() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/error.png',
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 16),
        Text(
          'Something went wrong!',
          style: const TextStyle(
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

 Widget _buildIconAndDescription({img, description}) {
  
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(
        img,
        width: 24,
        height: 24,
      ),
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


