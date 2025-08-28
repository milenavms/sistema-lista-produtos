import 'package:dio/dio.dart';
import 'package:projeto_lista_produtos/domain/models/product_model.dart';

class ApiController {
  final Dio _dioUrlAPI = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com"));

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dioUrlAPI.get('/products');

      final List<dynamic> data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Erro na requisição: ${e.message}");
    }
  }
}
