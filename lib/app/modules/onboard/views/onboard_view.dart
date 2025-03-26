import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/clrs.dart';
import '../../../data/prefs.dart';
import '../../../designs/custom_img.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/helper.dart';
import '../controllers/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          PageView(
            controller: controller.pageCon,
            onPageChanged: (value) {
              controller.pageNo.value = value;
            },
            children: controller.onboards.map(
              (e) {
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      CustomImg(
                        imgUrl: e.image,
                        imgWidth: double.infinity,
                        imgHeight: double.infinity,
                        imgFit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 150.h,
                        left: 20.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 300.w,
                              child: Text(
                                e.title,
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  color: AppClrs.kPrimaryTxtClr,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            addH(10.h),
                            SizedBox(
                              width: Get.width - 60.w,
                              child: Text(
                                e.subtitle,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: AppClrs.kPrimaryTxtClr,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            addH(10.h),
                            SizedBox(
                              width: 300.w,
                              child: Text(
                                e.description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppClrs.kPrimaryTxtClr,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 40.w,
                        right: 15.w,
                        child: Obx(() {
                          double percentage = (controller.pageNo.value + 1) /
                              controller.onboards.length;
                          if (percentage > 1.0) {
                            percentage = 1.0;
                          }
                          return CircularPercentIndicator(
                            radius: 40.r,
                            lineWidth: 5.0,
                            percent: percentage,
                            backgroundColor: Colors.white,
                            backgroundWidth: 1,
                            progressColor: Colors.white,
                            center: InkWell(
                              onTap: () {
                                if (controller.pageNo.value ==
                                    controller.onboards.length - 1) {
                                  Preference.setOnboardFlag(true);
                                  Get.offAllNamed(Routes.LOGIN);
                                  return;
                                }
                                controller.pageCon.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                                controller.pageNo.value++;
                              },
                              child: Container(
                                width: 60.w,
                                height: 60.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppClrs.kPrimaryClr,
                                  size: 20.w,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      addH(30.h),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 50.h,
              left: 20.w,
            ),
            child: SmoothPageIndicator(
              controller: controller.pageCon,
              count: controller.onboards.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 4,
                dotWidth: 10,
                dotColor: Colors.grey,
                activeDotColor: Colors.white,
              ),
              onDotClicked: (index) {},
            ),
          ),
        ],
      ),
    );
  }
}
