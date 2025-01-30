import 'package:dio/dio.dart';
import 'package:test_flutter_task/data/models/catagory/catagories_model.dart';

import 'package:test_flutter_task/data/models/product/products_model.dart';
import 'package:test_flutter_task/data/repositories/api_endpoint.dart';

class ProductRepository {
  Dio dio = Dio();
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await dio.get('${ApiEndpoints.APIURL}?limit=100');

      if (response.statusCode == 200) {
        final List data = response.data['products'];
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
  Dio dio = Dio();
  Future<List<Catagories>> fetchCatagories() async {
    try {
      final response = await dio.get('${ApiEndpoints.APIURL}/categories');

      if (response.statusCode == 200) {
        final List data = response.data;
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
  Dio dio = Dio();
  Future<List<Product>> fetchProductsBYCatagory(url) async {
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final List data = response.data['products'];
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
