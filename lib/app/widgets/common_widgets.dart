import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/clrs.dart';

class TitleTxt extends StatelessWidget {
  final String title;
  double? fSize;
  FontWeight? fWeight;
  TextDecoration? tDecoration;
  int? maxL;
  Color? txtClr;
  TitleTxt({
    super.key,
    required this.title,
    this.fSize,
    this.fWeight,
    this.tDecoration,
    this.maxL,
    this.txtClr,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxL,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: 1.1,
        fontSize: fSize ?? 24.sp,
        color: txtClr ?? AppClrs.kPrimaryClr,
        decoration: tDecoration,
        fontWeight: fWeight ?? FontWeight.bold,
      ),
    );
  }
}
