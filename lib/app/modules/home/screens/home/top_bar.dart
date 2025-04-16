import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../data/clrs.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/home_controller.dart';

class TopBar extends StatelessWidget {
  final HomeController controller;
  const TopBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: AppClrs.kPrimaryClr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // menu icon
            InkWell(
              onTap: controller.zdCon.toggle,
              child: SizedBox(
                width: 24.w,
                height: 24.h,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/svgs/menu.svg',
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Image.asset(
                    'assets/imgs/banner.jpg',
                    height: 55.h,
                    fit: BoxFit.cover,
                  ),
                  //  Column(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     AutoSizeText(
                  //       'Health Guide',
                  //       maxLines: 1,
                  //       minFontSize: 10,
                  //       style: TextStyle(
                  //         fontSize: 18.sp,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     Text(
                  //       'The Best Deal',
                  //       style: TextStyle(
                  //         fontSize: 14.sp,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
            // notifications icon
            InkWell(
              onTap: () => Get.toNamed(
                Routes.NOTIFICATIONS,
              ),
              child: SizedBox(
                width: 24.w,
                height: 24.h,
                child: Center(
                  child: SvgPicture.asset(
                    // ? 'assets/svgs/bell_fill.svg':
                    'assets/svgs/bell.svg',
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
