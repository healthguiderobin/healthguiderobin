import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/helper.dart';

class CustomDD extends StatelessWidget {
  final dynamic givenValue;
  final String hintTxt;
  final List<DropdownMenuItem<dynamic>>? items;
  final Function(dynamic) onChangedFn;
  double? ddWidth;
  CustomDD({
    Key? key,
    required this.givenValue,
    required this.hintTxt,
    required this.items,
    required this.onChangedFn,
    this.ddWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ddWidth ?? double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<dynamic>(
          hint: Row(
            children: [
              addW(15.w),
              Text(
                hintTxt,
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          value: givenValue,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items: items,
          onChanged: onChangedFn,
        ),
      ),
    );
  }
}
