import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';
import 'package:projeto_lista_produtos/screens/components/custom_app_bar.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_icon.dart';
import 'package:projeto_lista_produtos/screens/components/info_row.dart';

class ProductDetails extends StatelessWidget {
  final int? productId;

  ProductDetails({super.key,required this.productId});

  final List<Product> productList = [
    Product(
      id: 1,
      title: 'Produto 1',
      description: 'Produto 1',
      category: 'Categoria 1',
      price: 10.99,
      image: 'https://via.placeholder.com/150',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    Product? product;

    try {
      product = productList.firstWhere((p) => p.id == productId);
    } catch (e) {
      product = null;
    }

    final bool isProductNull = product == null;

    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: true,
        roteGoBack: "/",
        title: 'Product Details',
        iconWidget: FavoriteIcon(
          isFavorite: !isProductNull,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: kIsWeb ? Colors.grey[200] : Colors.white ,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
                minWidth: kIsWeb ? 800 : MediaQuery.of(context).size.height * 0.8,
                maxWidth: kIsWeb ? 800 : double.infinity,
              ),
              child: !isProductNull 
                  ? _buildProductDetails(product)
                  : SizedBox(
                      height: MediaQuery.of(context).size.height - kToolbarHeight,
                      child: Center(
                        child: _buildErrorMessage(),
                      ),
              ),
            ),
          ),
        ),
      ),
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
          SizedBox(
            width: 310,
            height: 320,
            child: Image.network(
              product.image,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            child: Text(
              product.description,
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
            text: "Descricao do produto",
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

          _buildIconAndDescription(img: 'assets/query_builder-left.png', description: 'djhbcvewbch'),

        
          const SizedBox(height: 16),

          _buildIconAndDescription(img: 'assets/query_builder-justify.png', description: 'djhbcvewbch'),

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
      children: [
        Image.asset(
          img,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 8),
        Text(
          description,
          style: const TextStyle(
          fontSize: 16, 
          fontFamily: 'Poppins', 
          fontWeight: FontWeight.w500),
        ),
      ],
    );
            
  }

}
