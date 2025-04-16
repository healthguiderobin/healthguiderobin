import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../designs/custom_img.dart';
import '../../../utils/methods.dart';
import '../../../widgets/body_widget.dart';
import '../../../widgets/helper.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        title: 'Notifications',
        child: Expanded(
          child: Obx(() {
            if (controller.notificationsLF.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (controller.notificationList.isEmpty) {
                return const Center(
                  child: Text(
                    'No notifications found!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.notificationList.length,
                itemBuilder: (context, index) {
                  final notification = controller.notificationList[index];
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 5.h,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (notification.image.isNotEmpty)
                            InkWell(
                              onTap: () => Methods.openImageView(
                                context,
                                imgUrl: notification.image,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.r),
                                ),
                                child: CustomImg(
                                  imgUrl: notification.image,
                                  imgWidth: Get.width,
                                  imgHeight: 200.h,
                                  imgFit: BoxFit.cover,
                                ),
                              ),
                            ),
                          if (notification.image.isNotEmpty) addH(10.h),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  notification.title,
                                  maxLines: 5,
                                ),
                              ),
                              addW(10.w),
                              Text(
                                Methods.formatTimestamp(
                                  notification.createdAt,
                                ),
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Text(
                        notification.body,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
