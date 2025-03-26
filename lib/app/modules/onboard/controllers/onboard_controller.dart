import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/onboard.dart';

class OnboardController extends GetxController {
  final PageController pageCon = PageController();
  List<OnboardModel> onboards = [];
  RxInt pageNo = 0.obs;
  @override
  void onInit() {
    super.onInit();
    onboards = Get.arguments ?? [];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
