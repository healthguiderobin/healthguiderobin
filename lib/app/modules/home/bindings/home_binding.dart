import 'package:get/get.dart';

import '../controllers/doctors_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<DoctorsController>(
      () => DoctorsController(),
    );
  }
}
