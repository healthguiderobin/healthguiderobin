import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/strings.dart';
import '../../../models/hospital.dart';
import '../../../utils/methods.dart';

class HospitalsController extends GetxController {
  RxBool hospitalsLF = false.obs;

  List<HospitalModel> hospitalsList = [];

  @override
  void onInit() {
    super.onInit();
    fetchHospitals();
  }

  void fetchHospitals() async {
    hospitalsLF.value = true;
    try {
      final collection = FirebaseFirestore.instance.collection(
        AppStrings.kHospitals,
      );
      try {
        final querySS = await collection.get();
        hospitalsList = querySS.docs.map((doc) {
          return HospitalModel.fromJson(doc.data());
        }).toList();
        hospitalsList.sort((a, b) => a.name.compareTo(b.name));
      } catch (e) {
        Methods.showSnackbar(
          title: 'Failed to fetch hospitals!',
          msg: 'Something went wrong. Please try again later.',
        );
      }
    } finally {
      hospitalsLF.value = false;
    }
  }
}
