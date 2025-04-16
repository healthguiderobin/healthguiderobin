import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../data/clrs.dart';
import 'helper.dart';

class BodyWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? suffixWidget;
  final bool? noBack;
  const BodyWidget({
    super.key,
    required this.title,
    required this.child,
    this.suffixWidget,
    this.noBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addH(15.h),
            Row(
              mainAxisAlignment: noBack == null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if (noBack == null)
                  InkWell(
                    onTap: () => Get.back(),
                    child: SizedBox(
                      width: 50.w,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppClrs.kPrimaryClr,
                      ),
                    ),
                  ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppClrs.kPrimaryClr,
                  ),
                ),
                if (noBack == null)
                  SizedBox(
                    width: 50.w,
                    child: suffixWidget,
                  ),
              ],
            ),
            Divider(
              thickness: 1,
              color: AppClrs.kPrimaryClr,
            ),
            // addH(10.h),
            child,
          ],
        ),
      ),
    );
  }
}
