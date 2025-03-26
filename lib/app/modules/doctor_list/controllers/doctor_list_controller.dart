import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/strings.dart';
import '../../../models/doctor.dart';
import '../../../utils/methods.dart';

class DoctorListController extends GetxController {
  RxBool doctorsLF = false.obs;

  List<DoctorModel> doctorList = [];

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  void fetchDoctors() async {
    doctorsLF.value = true;
    try {
      final collection = FirebaseFirestore.instance.collection(
        AppStrings.kDoctors,
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
