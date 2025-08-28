import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_lista_produtos/domain/models/product_model.dart';

class ApiController {
  static const String baseUrl = "https://fakestoreapi.com";

  /// Busca todos os produtos da API
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Mapeia cada item do JSON para um Product
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception(
          "Erro ao carregar produtos. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Erro na requisição: $e");
    }
  }
}
