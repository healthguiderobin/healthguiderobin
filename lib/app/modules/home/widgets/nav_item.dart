import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/helper.dart';

class NavItem extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  const NavItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isSelected) addH(10.h),
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Center(
            child: SvgPicture.asset(
              isSelected
                  ? 'assets/svgs/${icon}_fill.svg'
                  : 'assets/svgs/$icon.svg',
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        if (!isSelected)
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
    );
  }
}
