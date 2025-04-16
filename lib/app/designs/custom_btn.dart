import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../data/clrs.dart';
import '../widgets/helper.dart';

class CustomBtn extends StatelessWidget {
  final VoidCallback onPressedFn;
  final String btnTxt;
  final double? txtSize;
  final double? btnBorderRadius;
  final FontWeight? txtWeight;
  final Size? btnSize;
  final Color? btnColor;
  final Color? txtColor;
  final Color? btnBorderColor;
  final String? btnIcon;
  const CustomBtn({
    Key? key,
    required this.onPressedFn,
    required this.btnTxt,
    this.txtSize,
    this.txtWeight,
    this.btnSize,
    this.btnBorderRadius,
    this.btnColor,
    this.txtColor,
    this.btnBorderColor,
    this.btnIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedFn,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        fixedSize: WidgetStateProperty.all(
          btnSize ?? Size(388.w, 56.h),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          btnColor ?? AppClrs.kPrimaryClr,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnBorderRadius ?? 8),
            side: BorderSide(
              color: btnBorderColor != null
                  ? btnBorderColor!
                  : btnColor != null
                      ? btnColor!
                      : AppClrs.kPrimaryClr,
              width: 1.0,
            ),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (btnIcon != null)
            SvgPicture.asset(
              'assets/svgs/${btnIcon!}.svg',
              fit: BoxFit.fill,
              width: 22.w,
              height: 22.h,
              colorFilter: ColorFilter.mode(
                txtColor ?? AppClrs.kWhiteClr,
                BlendMode.srcIn,
              ),
            ),
          if (btnIcon != null) addW(5.w),
          AutoSizeText(
            btnTxt,
            minFontSize: 5,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: txtColor ?? AppClrs.kWhiteClr,
              fontSize: txtSize ?? 15.sp,
              fontWeight: txtWeight ?? FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
