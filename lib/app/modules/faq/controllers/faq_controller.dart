import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/strings.dart';
import '../../../models/faq.dart';

class FaqController extends GetxController {
  RxBool bannersLF = false.obs;
  List<FAQModel> faqList = [];

  @override
  void onInit() {
    super.onInit();
    fetchFAQs();
  }

  void fetchFAQs() async {
    bannersLF.value = true;
    try {
      final collection = FirebaseFirestore.instance.collection(
        AppStrings.kFAQs,
      );
      final querySS = await collection.get();
      faqList = querySS.docs.map((doc) {
        return FAQModel.fromJson(doc.data());
      }).toList();
    } finally {
      bannersLF.value = false;
    }
  }
}
