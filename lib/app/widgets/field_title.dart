import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../data/clrs.dart';

class FieldTitle extends StatelessWidget {
  final String titleTxt;
  const FieldTitle({
    Key? key,
    required this.titleTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        titleTxt,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppClrs.kPrimaryTxtClr,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
