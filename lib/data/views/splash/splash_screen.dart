import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_task/data/views/dashboard/dashboard_screen.dart';
import 'package:test_flutter_task/data/widgets/reponsive_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => DashboardScreen());
    });

    return Scaffold(
      body: SizedBox(
        height: getResponsiveHeight(context, 800),
        width: getResponsiveWidth(context, 360),
        child: Image.asset(
          "assets/images/splash.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
