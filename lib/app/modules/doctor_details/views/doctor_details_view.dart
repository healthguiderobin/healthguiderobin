import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/clrs.dart';
import '../../../designs/custom_img.dart';
import '../../../widgets/body_widget.dart';
import '../../../widgets/helper.dart';
import '../controllers/doctor_details_controller.dart';
import '../widgets/chamber_card.dart';

class DoctorDetailsView extends GetView<DoctorDetailsController> {
  const DoctorDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        title: 'Doctor Details',
        child: Expanded(
          child: RefreshIndicator(
            onRefresh: () async => controller.fetchChambers(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10.r),
                    ),
                    child: CustomImg(
                      imgUrl: controller.doctor.image,
                      imgWidth: Get.width,
                      imgHeight: 400.h,
                      imgFit: BoxFit.cover,
                    ),
                  ),
                  addH(10.h),
                  Row(
                    children: [
                      Container(
                        color: AppClrs.kPrimaryClr,
                        padding: EdgeInsets.all(5.r),
                        child: Text(
                          "Discount: ${controller.doctor.discount}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppClrs.kWhiteClr,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (controller.doctor.otDiscount.isNotEmpty)
                        Container(
                          color: AppClrs.kAccentClr,
                          padding: EdgeInsets.all(5.r),
                          margin: EdgeInsets.only(left: 10.r),
                          child: Text(
                            "OT Discount: ${controller.doctor.otDiscount}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppClrs.kWhiteClr,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  addH(10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Dr. ${controller.doctor.name}",
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: AppClrs.kPrimaryClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      addW(10.w),
                      Text(
                        controller.doctor.specialityName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppClrs.kAccentClr,
                        ),
                      ),
                    ],
                  ),
                  addH(5.h),
                  Text(
                    controller.doctor.degree,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppClrs.kAccentClr,
                    ),
                  ),
                  addH(5.h),
                  Text(
                    "${controller.doctor.experience} of Experience",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppClrs.kAccentClr,
                    ),
                  ),
                  addH(5.h),
                  Text(
                    controller.doctor.institution,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppClrs.kAccentClr,
                    ),
                  ),
                  addH(5.h),
                  Text(
                    controller.doctor.address,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppClrs.kAccentClr,
                    ),
                  ),
                  addH(10.h),
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppClrs.kPrimaryClr,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    controller.doctor.about,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  addH(10.h),
                  Text(
                    'Chambers',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppClrs.kPrimaryClr,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(() {
                    if (controller.chambersLF.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (controller.chamberList.isEmpty) {
                        return const Center(
                          child: Text('No Chambers Found'),
                        );
                      } else {
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.chamberList.length,
                          itemBuilder: (context, index) {
                            return ChamberCard(
                              chamber: controller.chamberList[index],
                            );
                          },
                        );
                      }
                    }
                  }),
                  addH(10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
