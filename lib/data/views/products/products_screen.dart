import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_task/data/controllers/products/products_controller.dart';
import 'package:test_flutter_task/data/views/product_details/product_details_screen.dart';
import 'package:test_flutter_task/data/widgets/app_color.dart';
import 'package:test_flutter_task/data/widgets/cText.dart';
import 'package:test_flutter_task/data/widgets/c_app_bar.dart';
import 'package:test_flutter_task/data/widgets/c_text_field.dart';
import 'package:test_flutter_task/data/widgets/product_card.dart';
import 'package:test_flutter_task/data/widgets/reponsive_layout.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());
    controller.productsearchcontroller.clear();
    return Scaffold(
      appBar: const CAppBar(
        title: 'Products',
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
                controller: controller.productsearchcontroller,
                borderColor: AppColor.black,
                borderRadius: 8,
                filled: false,
              ),
            ),
            SizedBox(
              height: getResponsiveHeight(context, 16),
            ),
            Obx(
              () => CText(
                text: controller.filteredProducts.isNotEmpty ? '${controller.filteredProducts.length} results found' : "",
                fontsize: 14,
                color: AppColor.grey,
              ),
            ),
            SizedBox(
              height: getResponsiveHeight(context, 16),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColor.grey.withOpacity(0.3),
                  ));
                } else if (controller.filteredProducts.isEmpty) {
                  return const Center(child: CText(text: "No data!"));
                }
                return ListView.builder(
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];

                    return GestureDetector(
                        onTap: () {
                          Get.to(ProductDetailsScreen(
                            productsBYCatatagory: product,
                          ));
                        },
                        child: ProductCard(product: product));
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
