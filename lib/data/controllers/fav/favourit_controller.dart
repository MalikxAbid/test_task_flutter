import 'package:get/get.dart';
import 'package:test_flutter_task/data/models/product/products_model.dart';

class FavoriteController extends GetxController {
  var favorites = <Product>[].obs;
  var filteredFavorites = <Product>[].obs;

  void toggleFavorite(Product product) {
    if (favorites.contains(product)) {
      favorites.remove(product);
    } else {
      favorites.add(product);
    }
    filterFavorites(""); // Refresh filtered list
  }

  bool isFavorite(Product product) {
    return favorites.contains(product);
  }

  void filterFavorites(String query) {
    if (query.isEmpty) {
      filteredFavorites.assignAll(favorites);
    } else {
      filteredFavorites.assignAll(
        favorites.where(
          (product) => product.title!.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }
}
