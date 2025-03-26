import 'package:get/get.dart';

import '../controllers/doctor_list_controller.dart';

class DoctorListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorListController>(
      () => DoctorListController(),
    );
  }
}
