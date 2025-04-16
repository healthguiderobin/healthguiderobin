import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/strings.dart';
import '../../../models/notification.dart';

class NotificationsController extends GetxController {
  final RxBool notificationsLF = false.obs;

  List<NotificationModel> notificationList = [];

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() async {
    notificationsLF.value = true;
    try {
      final ins = FirebaseFirestore.instance;
      final collection = ins.collection(
        AppStrings.kNotifications,
      );
      Query query = collection;
      // enable below line when pagination is required
      // Query query = collection.limit(20);
      query = query.orderBy('createdAt', descending: true);
      final querySS = await query.get() as QuerySnapshot<Map<String, dynamic>>;
      notificationList = querySS.docs.map((doc) {
        return NotificationModel.fromJson(doc.data());
      }).toList();
    } finally {
      notificationsLF.value = false;
    }
  }
}
