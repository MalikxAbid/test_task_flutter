import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_task/data/controllers/fav/favourit_controller.dart';
import 'package:test_flutter_task/data/models/product/products_model.dart';
import 'package:test_flutter_task/data/widgets/app_color.dart';
import 'package:test_flutter_task/data/widgets/cText.dart';
import 'package:test_flutter_task/data/widgets/c_app_bar.dart';
import 'package:test_flutter_task/data/widgets/c_text_field.dart';
import 'package:test_flutter_task/data/widgets/product_card.dart';
import 'package:test_flutter_task/data/widgets/reponsive_layout.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.find<FavoriteController>();
    TextEditingController favtext = TextEditingController();

    favtext.addListener(() {
      favoriteController.filterFavorites(favtext.text);
    });

    return Scaffold(
      appBar: const CAppBar(
        title: "Favourites",
        titleColor: AppColor.black,
      ),
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getResponsiveHeight(context, 40),
              child: CTextField(
                focusBorderColor: AppColor.black,
                prefexIcon: const Icon(Icons.search),
                hint: 'Search',
                borderColor: AppColor.black,
                borderRadius: 8,
                filled: false,
                controller: favtext,
              ),
            ),
            SizedBox(
              height: getResponsiveHeight(context, 16),
            ),
            Obx(
              () => CText(
                text: favoriteController.filteredFavorites.isNotEmpty ? '${favoriteController.filteredFavorites.length} results found' : "",
                fontsize: 14,
                color: AppColor.grey,
              ),
            ),
            SizedBox(
              height: getResponsiveHeight(context, 16),
            ),
            Expanded(
              child: Obx(() {
                if (favoriteController.filteredFavorites.isEmpty) {
                  return const Center(child: CText(text: "No favorite products"));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: favoriteController.filteredFavorites.length,
                    itemBuilder: (context, index) {
                      Product product = favoriteController.filteredFavorites[index];
                      return _buildFavouriteItem(product, favoriteController);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFavouriteItem(Product product, FavoriteController controller) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: AppColor.grey.withOpacity(0.1), width: 1),
        right: BorderSide(color: AppColor.grey.withOpacity(0.1), width: 1),
        bottom: BorderSide(color: AppColor.grey.withOpacity(0.1), width: 1),
      ),
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            imageUrl: product.images![0],
            height: 65,
            width: 65,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: AppColor.grey.withOpacity(0.3),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText(
                text: product.title.toString(),
                fontWeight: FontWeight.bold,
                fontsize: 14.0,
              ),
              const SizedBox(height: 5.0),
              CText(
                text: "\$${product.price.toString()}",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontsize: 14.0,
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  CText(
                    text: product.rating.toString(),
                    color: Colors.black,
                    fontsize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 5.0),
                  StarRating(
                    rating: double.parse(product.rating.toString()),
                    starSize: 12,
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            controller.toggleFavorite(product);
          },
        ),
      ],
    ),
  );
}
