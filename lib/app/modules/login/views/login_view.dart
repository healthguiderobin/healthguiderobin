import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/clrs.dart';
import '../../../data/prefs.dart';
import '../../../designs/custom_btn.dart';
import '../../../designs/custom_field.dart';
import '../../../utils/methods.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/field_title.dart';
import '../../../widgets/helper.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                addH(100.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.asset(
                    'assets/app_logo.jpg',
                    width: 180.w,
                    height: 180.h,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                addH(40.h),
                TitleTxt(
                  title: 'Welcome',
                  fSize: 24.sp,
                  txtClr: AppClrs.kPrimaryClr,
                  fWeight: FontWeight.bold,
                ),
                addH(20.h),
                TitleTxt(
                  title: 'Login to your account',
                  fSize: 16.sp,
                  txtClr: AppClrs.kPrimaryTxtClr,
                  fWeight: FontWeight.w400,
                ),
                addH(40.h),
                Row(
                  children: [
                    FieldTitle(titleTxt: 'Email'),
                  ],
                ),
                addH(10.h),
                CustomField(
                  textCon: controller.emailCon,
                  hintText: 'Enter your email',
                  inputType: TextInputType.emailAddress,
                ),
                addH(30.h),
                Row(
                  children: [
                    FieldTitle(titleTxt: 'Password'),
                  ],
                ),
                addH(10.h),
                CustomField(
                  textCon: controller.passCon,
                  hintText: 'Enter your password',
                  isPassField: true,
                ),
                addH(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 168.w,
                      height: 22.h,
                      child: Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.rememberMe.value,
                              onChanged: (value) =>
                                  controller.rememberMe.value = value!,
                              activeColor: AppClrs.kPrimaryTxtClr,
                              splashRadius: 0,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Remember Me',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppClrs.kPrimaryTxtClr,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      // () => Get.toNamed(
                      //   Routes.FORGOT_PASSWORD,
                      //   arguments: controller.emailCon.text,
                      // ),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppClrs.kPrimaryTxtClr,
                        ),
                      ),
                    ),
                  ],
                ),
                addH(60.h),
                CustomBtn(
                  onPressedFn: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (controller.emailCon.text.isEmpty ||
                        controller.passCon.text.isEmpty) {
                      Methods.showSnackbar(
                        title: 'Empty Fields!',
                        msg: 'Please fill all the fields.',
                      );
                      return;
                    }
                    if (!controller.emailCon.text.isEmail) {
                      Methods.showSnackbar(
                        title: 'Invalid Email!',
                        msg: 'Please enter a valid email',
                      );
                      return;
                    }
                    if (controller.passCon.text.length < 6) {
                      Methods.showSnackbar(
                        title: 'Short Password!',
                        msg: 'Password length must be greater then 5.',
                      );
                      return;
                    }
                    if (controller.rememberMe.value) {
                      Preference.setLoginEmail(controller.emailCon.text);
                      Preference.setLoginPass(controller.passCon.text);
                    }
                    Preference.setRememberMeFlag(
                      controller.rememberMe.value,
                    );
                    controller.loginUser();
                  },
                  btnTxt: 'Sign in',
                  btnBorderRadius: 30.r,
                  btnSize: Size(130.w, 56.h),
                ),
                addH(50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
