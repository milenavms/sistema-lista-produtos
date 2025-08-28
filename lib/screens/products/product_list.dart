import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_lista_produtos/controllers/api_controller.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';
import 'package:projeto_lista_produtos/screens/components/custom_app_bar.dart';
import 'package:projeto_lista_produtos/screens/components/custom_card_products.dart';
import 'package:projeto_lista_produtos/screens/components/favorite_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:projeto_lista_produtos/screens/components/search_button.dart';

class ProductList extends StatefulWidget {
  ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ApiController _apiController = ApiController();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _loading = true;

  final double marginTop = kIsWeb ? 16.0 : 0.0;
  final double marginBottom = kIsWeb ? 20.0 : 0.0;
  final double navbarHeight = kToolbarHeight; // default AppBar height

   Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _apiController.fetchProducts();

      setState(() {
        _allProducts = products.map((p) => p.copyWith(
        title: p.title.toLowerCase(),
      )).toList();
        _filteredProducts = products;
        _loading = false;
      });

    } catch (e) {
      setState(() {
        _loading = false;
      });
      debugPrint("Erro ao carregar produtos: $e");
    }
  }

  void _filterProducts(String query) {
    final filtered = _allProducts.where((p) {
      return p.title.contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredProducts = filtered;
    });
  }

 
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _filterProducts(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Products',
        iconWidget: FavoriteIcon(
          isFavorite: false,
          onPressed: () {
            context.go('/favorites');
          },
        ),
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
              child: Column(
                children: [
                  SearchButton(onChanged: _onSearchChanged),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          navbarHeight -
                          marginTop -
                          marginBottom -
                          100,
                      maxWidth: kIsWeb ? 800 : double.infinity,
                    ),
                    child: _loading
                        ? const Center(child: CircularProgressIndicator())
                        : _filteredProducts.isEmpty
                            ? _buildErrorMessage()
                            : Align(
                                alignment: Alignment.topCenter,
                                child: _buildProductList(_filteredProducts),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: products.map((product) {
          return InkWell(
            onTap: () {
              context.go('/details/${product.id}');
            },
            child: CustomCardProducts(product: product),
          );
        }).toList(),
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
            'assets/error_search.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 16),
          Text(
            'The list is empty',
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
}
