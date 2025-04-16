import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/strings.dart';
import '../../../models/speciality.dart';
import '../../../utils/methods.dart';

class DoctorsController extends GetxController {
  RxBool specialitiesLF = false.obs;

  List<SpecialityModel> specialityList = [];

  @override
  void onInit() {
    super.onInit();
    fetchSpecialities();
  }

  void fetchSpecialities() async {
    specialitiesLF.value = true;
    try {
      final collection = FirebaseFirestore.instance.collection(
        AppStrings.kSpecialities,
      );
      try {
        final querySS = await collection.get();
        specialityList = querySS.docs.map((doc) {
          return SpecialityModel.fromJson(doc.data());
        }).toList();
        specialityList.sort((a, b) => a.name.compareTo(b.name));
      } catch (e) {
        Methods.showSnackbar(
          title: 'Failed to fetch specialities!',
          msg: 'Something went wrong. Please try again later.',
        );
      }
    } finally {
      specialitiesLF.value = false;
    }
  }
}
