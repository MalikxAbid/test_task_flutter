import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_flutter_task/data/controllers/fav/favourit_controller.dart';
import 'package:test_flutter_task/data/views/dashboard/dashboard_screen.dart';
import 'package:test_flutter_task/data/views/splash/splash_screen.dart';

void main() {
  Get.put(FavoriteController());
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/products', page: () => DashboardScreen()),
      ],
    );
  }
}
