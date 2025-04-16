import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/clrs.dart';
import '../../../designs/custom_btn.dart';
import '../../../designs/custom_field.dart';
import '../../../utils/methods.dart';
import '../../../widgets/helper.dart';
import '../controllers/support_center_controller.dart';

class IssueSubmitSheet extends StatefulWidget {
  const IssueSubmitSheet({
    super.key,
  });

  @override
  State<IssueSubmitSheet> createState() => _IssueSubmitSheetState();
}

class _IssueSubmitSheetState extends State<IssueSubmitSheet> {
  final controller = Get.find<SupportCenterController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Submit Your Issue',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppClrs.kPrimaryClr,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          addH(10.h),
          CustomField(
            textCon: controller.titleCon,
            hintText: 'Title',
          ),
          addH(10.h),
          CustomField(
            textCon: controller.bodyCon,
            hintText: 'Description',
            height: 120.h,
            maxLine: 4,
          ),
          addH(10.h),
          CustomBtn(
            onPressedFn: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (controller.titleCon.text.isEmpty ||
                  controller.bodyCon.text.isEmpty) {
                Methods.showSnackbar(
                  title: 'Empty Field!',
                  msg: 'Please enter title and description.',
                );
                return;
              }
              controller.submitIssue();
            },
            btnTxt: 'Submit',
          ),
        ],
      ),
    );
  }
}
