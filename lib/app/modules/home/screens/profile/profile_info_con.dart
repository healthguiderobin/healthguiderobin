import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/clrs.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../widgets/helper.dart';

class ProfileInfoCon extends StatelessWidget {
  final String icon;
  final String info;
  const ProfileInfoCon({
    super.key,
    required this.icon,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      padding: EdgeInsets.only(left: 40.w),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppClrs.kPrimaryClr,
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svgs/$icon.svg',
            width: 22.w,
            height: 22.h,
            colorFilter: ColorFilter.mode(
              AppClrs.kPrimaryClr,
              BlendMode.srcIn,
            ),
          ),
          addW(20.w),
          TitleTxt(
            title: info,
            fSize: 16.sp,
          ),
        ],
      ),
    );
  }
}
