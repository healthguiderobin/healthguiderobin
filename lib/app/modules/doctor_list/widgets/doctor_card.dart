import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/clrs.dart';
import '../../../designs/custom_img.dart';
import '../../../models/doctor.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/helper.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.DOCTOR_DETAILS,
        arguments: doctor,
      ),
      child: Container(
        width: Get.width,
        height: 230.h,
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(
          bottom: 10.h,
        ),
        decoration: BoxDecoration(
          color: AppClrs.kPrimaryClr,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: Get.height,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppClrs.kWhiteClr,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10.r),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CustomImg(
                        imgUrl: doctor.image,
                        imgHeight: 200.h,
                        imgFit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppClrs.kAccentClr,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        "${doctor.discount} off",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppClrs.kWhiteClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            addW(10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppClrs.kAccentClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // name
                      Text(
                        "Dr. ${doctor.name}",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppClrs.kWhiteClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Degree',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppClrs.kAccentClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // degree
                      Text(
                        doctor.degree,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppClrs.kWhiteClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Speciality',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppClrs.kAccentClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // speciality
                      Text(
                        doctor.specialityName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppClrs.kWhiteClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Institution',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppClrs.kAccentClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // institution
                      Text(
                        doctor.institution,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppClrs.kWhiteClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // addH(5.h),
                  // Text(
                  //   'Address',
                  //   style: TextStyle(
                  //     fontSize: 12.sp,
                  //     color: AppClrs.kAccentClr,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // // address
                  // Text(
                  //   doctor.address,
                  //   style: TextStyle(
                  //     fontSize: 14.sp,
                  //     color: AppClrs.kWhiteClr,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
