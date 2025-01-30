import 'package:http/http.dart' as http;
import 'package:test_flutter_task/data/models/catagory/catagories_model.dart';
import 'dart:convert';

import 'package:test_flutter_task/data/models/product/products_model.dart';
import 'package:test_flutter_task/data/repositories/api_endpoint.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('${ApiEndpoints.APIURL}?limit=100'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['products'];
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}

class CategoriesRepository {
  Future<List<Catagories>> fetchCatagories() async {
    try {
      final response = await http.get(Uri.parse('${ApiEndpoints.APIURL}/categories'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((item) => Catagories.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}

class ProductBtCatagoryRepository {
  Future<List<Product>> fetchProductsBYCatagory(url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['products'];
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
