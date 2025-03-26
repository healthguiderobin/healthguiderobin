import 'package:get/get.dart';

import '../../../models/post.dart';

class PostDetailsController extends GetxController {
  late PostModel postItem;
  @override
  void onInit() {
    super.onInit();
    postItem = Get.arguments;
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
