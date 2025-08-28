import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lista_produtos/controllers/api_controller.dart';
import 'package:projeto_lista_produtos/controllers/favorites_helper.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';
import 'package:projeto_lista_produtos/screens/components/custom_app_bar.dart';
import 'package:projeto_lista_produtos/screens/components/custom_card_products.dart';

class ProductFavorites extends StatefulWidget {
  const ProductFavorites({super.key});

  @override
  ProductFavoritesState createState() => ProductFavoritesState();
}

class ProductFavoritesState extends State<ProductFavorites> {
  final double marginTop = kIsWeb ? 16.0 : 0.0;
  final double marginBottom = kIsWeb ? 20.0 : 0.0;
  final double navbarHeight = kToolbarHeight;

  bool _loading = true;
  List<Product> _favoriteProducts = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteProducts();
  }

  Future<void> _loadFavoriteProducts() async {
    setState(() => _loading = true);

    try {
      final allProducts = await ApiController().fetchProducts();
      final favoriteIds = await FavoritesHelper.getFavorites();

      setState(() {
        _favoriteProducts = allProducts.where((p) => favoriteIds.contains(p.id)).toList();
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      debugPrint("Erro ao carregar favoritos: $e");
    }
  }

  bool get hasProducts => _favoriteProducts.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
        roteGoBack: "/",
        title: 'Favorites',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.grey[200],
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(8),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - navbarHeight - marginTop - marginBottom - 20,
                  maxWidth: kIsWeb ? 800 : double.infinity,
                ),
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : hasProducts
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: _buildProductList(_favoriteProducts),
                          )
                        : Center(child: _buildErrorMessage()),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return Column(
      children: products.map((product) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/details',
              arguments: {'id': product.id},
            ).then((_) => _loadFavoriteProducts()); // recarrega ao voltar
          },
          child: CustomCardProducts(product: product, isFavoriteVisibleIcon: false),
        );
      }).toList(),
    );
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/error_search.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 16),
          const Text(
            'The list is empty',
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
