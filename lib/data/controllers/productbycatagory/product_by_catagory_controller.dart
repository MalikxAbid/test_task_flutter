import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_task/data/models/product/products_model.dart';
import 'package:test_flutter_task/data/repositories/api_services.dart';

class ProductByCatagoryController extends GetxController {
  final String url;
  ProductByCatagoryController({required this.url});

  TextEditingController searchcontroller = TextEditingController();
  final ProductBtCatagoryRepository _repository = ProductBtCatagoryRepository();

  var productByCatagory = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductsBYCatagory(url);

    searchcontroller.addListener(() {
      filterProducts(searchcontroller.text);
    });
  }

  void fetchProductsBYCatagory(String url) async {
    try {
      isLoading(true);
      var fetchedProducts = await _repository.fetchProductsBYCatagory(url);
      productByCatagory.assignAll(fetchedProducts);
      filteredProducts.assignAll(fetchedProducts);
    } finally {
      isLoading(false);
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(productByCatagory);
    } else {
      filteredProducts.assignAll(
        productByCatagory.where(
          (product) => product.title!.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  @override
  void onClose() {
    searchcontroller.clear(); // Clear search text when controller is closed
    super.onClose();
  }
}
