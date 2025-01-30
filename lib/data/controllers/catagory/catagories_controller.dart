import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_task/data/models/catagory/catagories_model.dart';
import 'package:test_flutter_task/data/repositories/api_services.dart';

class CatagoriesController extends GetxController {
  TextEditingController Catagorysearchcontroller = TextEditingController();
  final CategoriesRepository _repository = CategoriesRepository();

  var catagories = <Catagories>[].obs;
  var filteredCategories = <Catagories>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCatagories();

    // Listen to search text changes
    Catagorysearchcontroller.addListener(() {
      filterCategories(Catagorysearchcontroller.text);
    });
  }

  void fetchCatagories() async {
    try {
      isLoading(true);
      var fetchedCategories = await _repository.fetchCatagories();
      catagories.assignAll(fetchedCategories);
      filteredCategories.assignAll(fetchedCategories); // Initially all categories
    } finally {
      isLoading(false);
    }
  }

  void filterCategories(String query) {
    if (query.isEmpty) {
      filteredCategories.assignAll(catagories);
    } else {
      filteredCategories.assignAll(
        catagories.where(
          (category) => category.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }
}
