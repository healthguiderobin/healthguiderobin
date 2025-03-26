import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/clrs.dart';
import '../../../designs/custom_img.dart';
import '../../../widgets/helper.dart';

class DoctorItem extends StatelessWidget {
  const DoctorItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10.r),
            ),
            child: CustomImg(
              // imgUrl: hCon.doctorList[index].image,
              imgUrl: '',
              imgWidth: 180.w,
              imgHeight: 200.h,
            ),
          ),
          Expanded(
            child: Container(
              height: 200.h,
              padding: EdgeInsets.all(10.r),
              color: AppClrs.kCardBGClr,
              child: Stack(
                children: [
                  Positioned(
                    top: 0.h,
                    left: 10.w,
                    child: Text(
                      // hCon.doctorList[index].name,
                      '',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.1),
                        fontSize: 75.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name
                      Text(
                        // 'Dr. ${hCon.doctorList[index].name}',
                        'Dr. John Doe',
                        style: TextStyle(
                          color: AppClrs.kWhiteClr,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      addH(5.h),
                      // degree
                      Text(
                        // hCon.doctorList[index].degree,
                        'MBBS',
                        style: TextStyle(
                          color: AppClrs.kWhiteClr,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      addH(5.h),
                      // institution
                      Text(
                        // hCon.doctorList[index].institution,
                        'Medical University of Liberia',
                        style: TextStyle(
                          color: AppClrs.kWhiteClr,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      addH(5.h),
                      // richtext for speciality
                      RichText(
                        text: TextSpan(
                          text: 'Speciality: ',
                          style: TextStyle(
                            color: AppClrs.kWhiteClr,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              // text: hCon.doctorList[index]
                              //     .speciality,
                              text: 'Cardiology',
                              style: TextStyle(
                                color: AppClrs.kSecondaryClr,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
