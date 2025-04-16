import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/strings.dart';
import '../../../models/doctor.dart';
import '../../../models/speciality.dart';
import '../../../utils/methods.dart';

class DoctorListController extends GetxController {
  late SpecialityModel speciality;
  RxBool doctorsLF = false.obs;

  List<DoctorModel> doctorList = [];

  @override
  void onInit() {
    super.onInit();
    speciality = Get.arguments;
    print(speciality.id);
    fetchDoctors();
  }

  void fetchDoctors() async {
    doctorsLF.value = true;
    try {
      final collection = FirebaseFirestore.instance
          .collection(
            AppStrings.kDoctors,
          )
          .where(
            AppStrings.kSpecialityId,
            isEqualTo: speciality.id,
          );
      try {
        final querySS = await collection.get();
        doctorList = querySS.docs.map((doc) {
          return DoctorModel.fromJson(doc.data());
        }).toList();
      } catch (e) {
        Methods.showSnackbar(
          title: 'Failed to fetch doctor list!',
          msg: 'Something went wrong. Please try again later.',
        );
      }
    } finally {
      doctorsLF.value = false;
    }
  }
}
