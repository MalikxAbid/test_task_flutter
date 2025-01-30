import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_task/data/controllers/fav/favourit_controller.dart';
import 'package:test_flutter_task/data/models/product/products_model.dart';
import 'package:test_flutter_task/data/widgets/app_color.dart';
import 'package:test_flutter_task/data/widgets/cText.dart';
import 'package:test_flutter_task/data/widgets/c_app_bar.dart';
import 'package:test_flutter_task/data/widgets/product_card.dart';
import 'package:test_flutter_task/data/widgets/reponsive_layout.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product productsBYCatatagory;
  const ProductDetailsScreen({super.key, required this.productsBYCatatagory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CAppBar(
        title: "Product Details",
        titleColor: AppColor.black,
      ),
      backgroundColor: AppColor.white,
      body: GetBuilder<FavoriteController>(builder: (favoriteController) {
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            CachedNetworkImage(
              imageUrl: productsBYCatatagory.images![0],
              height: getResponsiveHeight(context, 200),
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: AppColor.grey.withOpacity(0.3),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 20),

            // Product Details
            Row(
              children: [
                CText(
                  text: "Product Details:",
                  fontWeight: FontWeight.bold,
                  fontsize: getResponsiveHeight(context, 18),
                  color: AppColor.black,
                ),
                const Spacer(),
                Obx(() => IconButton(
                      onPressed: () {
                        favoriteController.toggleFavorite(productsBYCatatagory);
                      },
                      icon: Icon(
                        favoriteController.isFavorite(productsBYCatatagory) ? Icons.favorite : Icons.favorite_border,
                        color: favoriteController.isFavorite(productsBYCatatagory) ? Colors.red : null,
                      ),
                    )),
              ],
            ),
            SizedBox(height: getResponsiveHeight(context, 10)),
            ...[
              detailsRow("Name", productsBYCatatagory.title.toString()),
              detailsRow("Price", "\$${productsBYCatatagory.price}"),
              detailsRow("Category", productsBYCatatagory.category.toString()),
              detailsRow("Brand", productsBYCatatagory.brand.toString()),
              detailsRow(
                "Rating",
                productsBYCatatagory.rating.toString(),
                trailing: StarRating(
                  rating: double.parse(productsBYCatatagory.rating.toString()),
                  starSize: getResponsiveHeight(context, 12),
                ),
              ),
              detailsRow("Stock", productsBYCatatagory.stock.toString()),
            ],
            SizedBox(height: getResponsiveHeight(context, 10)),
            CText(
              textAlign: TextAlign.start,
              text: "Description:",
              fontWeight: FontWeight.bold,
              fontsize: getResponsiveHeight(context, 16),
              color: AppColor.black,
            ),
            const SizedBox(height: 5),
            Text(
              productsBYCatatagory.description.toString(),
              style: const TextStyle(
                color: AppColor.black,
              ),
            ),
            SizedBox(height: getResponsiveHeight(context, 10)),

            CText(
              textAlign: TextAlign.start,
              text: "Product Gallery:",
              fontWeight: FontWeight.bold,
              fontsize: getResponsiveHeight(context, 18),
              color: AppColor.black,
            ),
            SizedBox(height: getResponsiveHeight(context, 10)),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: productsBYCatatagory.images!.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: productsBYCatatagory.images![index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColor.grey.withOpacity(0.3),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                );
              },
            )
          ],
        );
      }),
    );
  }

  Widget detailsRow(String title, String value, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          CText(
            text: "$title :",
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CText(
              textAlign: TextAlign.start,
              text: value,
              color: AppColor.black,
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
