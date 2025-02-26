import 'package:get/get.dart';

import '../../../data/prefs.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/methods.dart';

class SplashController extends GetxController {
  final String appName = 'Health Guide';
  @override
  void onInit() {
    super.onInit();
    navigating();
  }

  void navigating() async {
    if (Preference.getOnboardFlag()) {
      Methods.navigatingFn();
    } else {
      Get.offAllNamed(
        Routes.ONBOARD,
      );
    }
  }
}
