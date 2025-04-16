import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/clrs.dart';
import '../../../../widgets/helper.dart';

class InfoRow extends StatelessWidget {
  final String label, value;
  final Widget? trailingWidget;
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppClrs.kPrimaryClr,
            ),
          ),
          addW(10.w),
          Expanded(
            child: trailingWidget ??
                Text(
                  value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: AppClrs.kAccentClr,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
