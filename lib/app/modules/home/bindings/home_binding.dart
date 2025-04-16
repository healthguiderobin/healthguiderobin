import 'package:get/get.dart';

import '../controllers/doctors_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/hospitals_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/scan_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<DoctorsController>(
      () => DoctorsController(),
    );
    Get.lazyPut<ScanController>(
      () => ScanController(),
    );
    Get.lazyPut<HospitalsController>(
      () => HospitalsController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
