import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../data/prefs.dart';
import '../designs/custom_btn.dart';
import '../routes/app_pages.dart';
import '../widgets/helper.dart';

class Methods {
  static void showSnackbar({
    // required BuildContext context,
    String? title,
    required String msg,
    int? duration,
    IconData? icon,
    Color? iconClr,
    Color? bgClr,
    SnackPosition? position,
    bool? successFlag,
  }) {
    // ScaffoldMessenger.of(context).showSnackBar(snackBar(
    //   title: title,
    //   msg: msg,
    //   icon: icon,
    //   position: position,
    // ));
    Get.snackbar(
      title ?? 'Error',
      msg,
      icon: Icon(
        successFlag != null ? Icons.check_circle_outline : icon ?? Icons.error,
        color: successFlag != null ? Colors.green : iconClr ?? Colors.red,
      ),
      snackPosition: position ?? SnackPosition.BOTTOM,
      animationDuration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 20),
      duration: Duration(seconds: duration ?? 3),
      backgroundColor: bgClr,
    );
  }

  static void navigatingFn() {
    if (Preference.getLoggedInFlag()) {
      Future.delayed(
        const Duration(seconds: 2),
        () => Get.offAllNamed(Routes.HOME),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () => Get.offAllNamed(Routes.LOGIN),
      );
    }
  }

  static void showLoading() {
    if (!EasyLoading.isShow) {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
    }
  }

  static void hideLoading() => EasyLoading.dismiss();

  static DropdownMenuItem<dynamic> getDDMenuItem({
    required dynamic item,
    required String txt,
  }) {
    return DropdownMenuItem(
      value: item,
      child: Row(
        children: [
          addW(15),
          Text(
            txt,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // Image Uploading Methods
  static Widget buildDPAlertDialog({
    required Future<void> Function(bool) onPressedFn,
    required BuildContext ctx,
  }) {
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.all(0),
      titlePadding: EdgeInsets.symmetric(horizontal: 10.w),
      contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 30.h),
      backgroundColor: Colors.transparent,
      title: Container(
        height: 130.h,
        width: MediaQuery.of(ctx).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            buildImgSelectBtn(
              onPressedFn: onPressedFn,
              title: "Camera",
              galleryFlag: false,
            ),
            Divider(indent: 20.w, endIndent: 20.w, thickness: 1),
            buildImgSelectBtn(
              onPressedFn: onPressedFn,
              title: "Choose from gallery",
              galleryFlag: true,
            ),
          ],
        ),
      ),
      content: CustomBtn(
        onPressedFn: () => Get.back(),
        btnTxt: "Cancel",
      ),
    );
  }

  static TextButton buildImgSelectBtn({
    required Future<void> Function(bool) onPressedFn,
    required String title,
    required bool galleryFlag,
  }) {
    return TextButton(
      onPressed: () async {
        onPressedFn(galleryFlag);
        Get.back();
      },
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(354.w, 54.h)),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static void openImageView(
    BuildContext context, {
    File? imgFile,
    String? imgUrl,
  }) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 896.h,
        width: 414.w,
        child: Stack(
          children: [
            imgUrl != null
                ? PhotoView(
                    imageProvider: NetworkImage(imgUrl),
                    loadingBuilder: (context, imageChunk) => Center(
                      child: SizedBox(
                        height: 50.h,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Container(
                          height: 400.h,
                          width: Get.width,
                          padding: EdgeInsets.all(10.h),
                          margin: EdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/imgs/img_ph.png',
                                height: 300.h,
                                width: 300.w,
                              ),
                              addH(20.h),
                              const Text(
                                "The image cannot be displayed.",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : PhotoView(
                    imageProvider: FileImage(imgFile!),
                    loadingBuilder: (context, imageChunk) => Center(
                      child: SizedBox(
                        height: 50.h,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Container(
                          height: 50.h,
                          padding: EdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: const Text(
                              "Error Occured!",
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            Positioned(
              left: 10.w,
              top: 10.h,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => Get.back(),
                child: SvgPicture.asset(
                  'assets/svgs/back.svg',
                  height: 28.h,
                  width: 28.w,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static int createUniqueId() {
    Random rnd = Random();
    int min = 1111111;
    int max = 9999999;
    int r = min + rnd.nextInt(max - min);
    return r;
  }

  static String formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    String timeInText = timeago.format(
      dateTime,
      locale: 'en_short',
      allowFromNow: true,
    );
    if (timeInText != 'now') {
      return timeInText + ' ago';
    } else {
      return 'just now';
    }
  }

  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }
}
