import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_task/data/controllers/catagory/catagories_controller.dart';
import 'package:test_flutter_task/data/views/productbycatagory/product_byc_atagory_screen.dart';
import 'package:test_flutter_task/data/widgets/app_color.dart';
import 'package:test_flutter_task/data/widgets/cText.dart';
import 'package:test_flutter_task/data/widgets/c_app_bar.dart';
import 'package:test_flutter_task/data/widgets/c_text_field.dart';
import 'package:test_flutter_task/data/widgets/reponsive_layout.dart';

class CategoryListScreen extends StatelessWidget {
  final CatagoriesController controller = Get.put(CatagoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CAppBar(
        title: 'Categories',
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
                controller: controller.Catagorysearchcontroller,
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
                text: '${controller.filteredCategories.length} results found',
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
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.filteredCategories.isEmpty) {
                  return const Center(child: CText(text: "No categories!"));
                }
                return GridView.builder(
                  itemCount: controller.filteredCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    final category = controller.filteredCategories[index];
                    return CategoryCard(
                      url: category.url,
                      name: category.name,
                    );
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

class CategoryCard extends StatelessWidget {
  final String url;
  final String name;

  const CategoryCard({
    super.key,
    required this.url,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductBycAtagoryScreen(
          url: url,
          name: name,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: getResponsiveHeight(context, 125),
          width: getResponsiveWidth(context, 132),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: const DecorationImage(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: CText(
                text: name,
                color: Colors.white,
                fontsize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
