import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_task/data/models/product/products_model.dart';
import 'package:test_flutter_task/data/repositories/api_services.dart';

class ProductController extends GetxController {
  TextEditingController productsearchcontroller = TextEditingController();
  final ProductRepository _repository = ProductRepository();

  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    productsearchcontroller.addListener(() {
      filterProducts(productsearchcontroller.text);
    });
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var fetchedProducts = await _repository.fetchProducts();
      products.assignAll(fetchedProducts);
      filteredProducts.assignAll(fetchedProducts);
    } finally {
      isLoading(false);
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(products.where((product) => product.title!.toLowerCase().contains(query.toLowerCase())));
    }
  }

  @override
  void onClose() {
    productsearchcontroller.clear();
    super.onClose();
  }
}
