import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/prefs.dart';
import '../../../data/strings.dart';
import '../../../models/onboard.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/methods.dart';

class SplashController extends GetxController {
  final String splashImg = 'assets/imgs/splash.jpg';

  List<OnboardModel> onboards = [];
  @override
  void onInit() {
    super.onInit();
    navigating();
  }

  void navigating() async {
    if (Preference.getOnboardFlag()) {
      Methods.navigatingFn();
    } else {
      bool resFlag = await getOnboards();
      if (resFlag) {
        print('✅ Onboard Data Found ✅');
        Future.delayed(
          const Duration(milliseconds: 2600),
          () => Get.offAllNamed(
            Routes.ONBOARD,
            arguments: onboards,
          ),
        );
      } else {
        Methods.navigatingFn();
      }
    }
  }

  Future<bool> getOnboards() async {
    try {
      CollectionReference screens = FirebaseFirestore.instance.collection(
        AppStrings.kOnboards,
      );

      QuerySnapshot querySnapshot = await screens.get();
      for (var item in querySnapshot.docs) {
        onboards.add(OnboardModel.fromJson(
          item.data() as Map<String, dynamic>,
        ));
      }
      return onboards.isNotEmpty;
    } finally {}
  }
}
