import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthguiderobin/app/designs/custom_img.dart';

import '../../../../designs/custom_btn.dart';
import '../../../../widgets/body_widget.dart';
import '../../../../widgets/helper.dart';
import '../../controllers/scan_controller.dart';

class ScanResult extends StatefulWidget {
  final String scannedData;
  const ScanResult({
    super.key,
    required this.scannedData,
  });

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  final controller = Get.find<ScanController>();

  @override
  void initState() {
    super.initState();
    controller.scannedUser = null;
    Future.delayed(const Duration(milliseconds: 100), () {
      controller.fetchUser(
        uId: widget.scannedData,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.r),
        ),
      ),
      child: BodyWidget(
        noBack: true,
        title: 'Scan Result',
        child: Expanded(
          child: Obx(() {
            if (controller.scanLF.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (controller.scannedUser == null) {
                return Center(
                  child: Text(
                    'No Member Found!',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addH(5.h),
                        Center(
                          child: SizedBox(
                            height: 230.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: CustomImg(
                                imgUrl: controller.scannedUser!.photoURL,
                                imgFit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        addH(20.h),
                        Text(
                          "Name: ${controller.scannedUser!.name}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        addH(10.h),
                        Text(
                          "Father Name: ${controller.scannedUser!.fatherName}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        addH(10.h),
                        Text(
                          "Email: ${controller.scannedUser!.email}",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        // member id
                        // addH(10.h),
                        // Text(
                        //   'Member ID: ${controller.scannedUser!.userId}',
                        //   style: const TextStyle(
                        //     fontSize: 12,
                        //   ),
                        // ),
                        addH(30.h),
                        Center(
                          child: CustomBtn(
                            btnTxt: 'Done',
                            onPressedFn: () {
                              controller.scannedUser = null;
                              Get.back();
                            },
                          ),
                        ),
                        addH(15.h),
                      ],
                    ),
                  ),
                );
              }
            }
          }),
        ),
      ),
    );
  }
}
