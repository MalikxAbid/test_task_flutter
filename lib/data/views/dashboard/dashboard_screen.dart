import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_task/data/views/categories/catagories_screen.dart';
import 'package:test_flutter_task/data/views/favorites/favorites_screen.dart';
import 'package:test_flutter_task/data/views/products/products_screen.dart';
import 'package:test_flutter_task/data/views/userprofile/user_profile_screen.dart';
import 'package:test_flutter_task/data/widgets/app_color.dart';
import '../../controllers/dashboard/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController dashboardController = Get.put(DashboardController());

  final List<Widget> screens = [
    const ProductListScreen(),
    CategoryListScreen(),
    const FavouritesScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[dashboardController.currentIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            backgroundColor: AppColor.black,
            currentIndex: dashboardController.currentIndex.value,
            onTap: dashboardController.changeTab,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag, color: AppColor.white),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category, color: AppColor.white),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: AppColor.white,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: AppColor.white),
                label: 'User',
              ),
            ],
          )),
    );
  }
}
