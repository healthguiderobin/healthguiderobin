import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/clrs.dart';
import '../../../../designs/custom_img.dart';

class SpecialityCard extends StatelessWidget {
  final String logo, title;
  final VoidCallback onTapFn;
  const SpecialityCard({
    super.key,
    required this.logo,
    required this.title,
    required this.onTapFn,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFn,
      borderRadius: BorderRadius.circular(10.r),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppClrs.kPrimaryClr.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CustomImg(
                    imgUrl: logo,
                    imgWidth: 80.w,
                    imgHeight: 80.h,
                  ),
                ),
              ),
              Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
