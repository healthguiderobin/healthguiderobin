import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/strings.dart';
import '../../../models/chamber.dart';
import '../../../models/doctor.dart';
import '../../../utils/methods.dart';

class DoctorDetailsController extends GetxController {
  late DoctorModel doctor;
  RxBool chambersLF = false.obs;
  List<ChamberModel> chamberList = [];
  @override
  void onInit() {
    super.onInit();
    doctor = Get.arguments;
    fetchChambers();
  }

  void fetchChambers() async {
    chambersLF.value = true;
    try {
      final ins = FirebaseFirestore.instance;
      final docRef = ins.collection(AppStrings.kDoctors).doc(doctor.id);
      final collection = docRef.collection(AppStrings.kChambers);
      try {
        final querySS = await collection.get();
        chamberList = querySS.docs.map((doc) {
          return ChamberModel.fromJson(doc.data());
        }).toList();
      } catch (e) {
        Methods.showSnackbar(
          title: 'Failed to fetch doctor list!',
          msg: 'Something went wrong. Please try again later.',
        );
      }
    } finally {
      chambersLF.value = false;
    }
  }
}
