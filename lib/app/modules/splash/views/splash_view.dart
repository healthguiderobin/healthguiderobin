import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        controller.splashImg,
        width: Get.width,
        height: Get.height,
        fit: BoxFit.cover,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Lottie.asset(
        'assets/jsons/splash.json',
        width: 300,
        height: 300,
        repeat: false,
        fit: BoxFit.cover,
      ),
    );
  }
}
