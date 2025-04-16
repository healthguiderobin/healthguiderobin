import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/strings.dart';
import '../../../models/user.dart';

class ScanController extends GetxController {
  RxBool scanLF = false.obs;

  UserModel? scannedUser;

  void fetchUser({required String uId}) async {
    scanLF.value = true;
    try {
      final collection = FirebaseFirestore.instance.collection(
        AppStrings.kUsers,
      );
      final userDoc = await collection.doc(uId).get();
      if (userDoc.exists) {
        UserModel obj = UserModel.fromJson(
          userDoc.data() as Map<String, dynamic>,
        );
        if (!obj.isDisabled) {
          scannedUser = obj;
        }
      }
    } finally {
      scanLF.value = false;
    }
  }
}
