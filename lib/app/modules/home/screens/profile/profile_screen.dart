import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../data/clrs.dart';
import '../../../../data/prefs.dart';
import '../../../../designs/custom_btn.dart';
import '../../../../designs/custom_field.dart';
import '../../../../designs/custom_img.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/methods.dart';
import '../../../../widgets/body_widget.dart';
import '../../../../widgets/helper.dart';
import '../../controllers/profile_controller.dart';
import 'info_row.dart';

class ProfileScreen extends StatefulWidget {
  final void Function(int) navigatingFn;
  const ProfileScreen({
    super.key,
    required this.navigatingFn,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        noBack: true,
        title: 'Profile',
        child: Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: InkWell(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addH(10.h),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              ClipOval(
                                child: SizedBox(
                                  height: 232.h,
                                  child:
                                      //  Obx(() {
                                      //   return
                                      Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      CustomImg(
                                        imgUrl:
                                            // controller.editingFlag.value &&
                                            //         controller.dpLink.value
                                            //             .isNotEmpty
                                            //     ? controller.dpLink.value
                                            //     :
                                            controller.user.photoURL,
                                        imgFit: BoxFit.cover,
                                      ),
                                      // if (controller.editingFlag.value)
                                      //   InkWell(
                                      //     onTap: () => showImgDialog(context),
                                      //     focusColor: Colors.transparent,
                                      //     hoverColor: Colors.transparent,
                                      //     splashColor: Colors.transparent,
                                      //     highlightColor: Colors.transparent,
                                      //     child: Container(
                                      //       height: 40.h,
                                      //       width: 300.w,
                                      //       decoration: BoxDecoration(
                                      //         color: AppClrs.kPrimaryClr,
                                      //         borderRadius:
                                      //             BorderRadius.circular(10.r),
                                      //       ),
                                      //       child: const Icon(
                                      //         Icons.upload,
                                      //         color: Colors.white,
                                      //       ),
                                      //     ),
                                      //   ),
                                    ],
                                  ),
                                  // ; }),
                                ),
                              ),
                              addH(16.h),
                              // SizedBox(
                              //     height: 40.h,
                              //     child:
                              //  Obx(() {
                              // if (controller.editingFlag.value) {
                              //   return CustomField(
                              //     textCon: controller.nameCon,
                              //     hintText: 'Enter Your Name',
                              //     height: 40.h,
                              //     width: Get.width * 0.8,
                              //   );
                              // } else {
                              // return
                              Text(
                                controller.user.name,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: AppClrs.kPrimaryClr,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // ;}
                              // }),
                              // ),
                              addH(8.h),
                              Text(
                                controller.user.email,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppClrs.kPrimaryClr,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Obx(() {
                        //   return CircleAvatar(
                        //     radius: 20.r,
                        //     backgroundColor: AppClrs.kPrimaryClr,
                        //     child: InkWell(
                        //       onTap: () => controller.editingFlag.toggle(),
                        //       highlightColor: Colors.transparent,
                        //       child: Icon(
                        //         controller.editingFlag.value
                        //             ? Icons.close
                        //             : Icons.edit,
                        //         size: 20.sp,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   );
                        // }),
                      ],
                    ),
                    addH(24.h),
                    // Medical Information Card
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: AppClrs.kPrimaryClr,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            addH(4.h),
                            Divider(),
                            addH(4.h),
                            InfoRow(
                              label: 'Father Name',
                              value: controller.user.fatherName,
                            ),
                            InfoRow(
                              label: 'Phone Number',
                              // trailingWidget: controller.editingFlag.value
                              //     ? CustomField(
                              //         textCon: controller.phoneCon,
                              //         hintText: 'Enter Your Phone Number',
                              //         height: 40.h,
                              //         textAlign: TextAlign.end,
                              //         width: Get.width * 0.8,
                              //       )
                              //     : null,
                              value: controller.user.phoneNumber,
                            ),
                            InfoRow(
                              label: 'Address',
                              // trailingWidget: controller.editingFlag.value
                              //     ? CustomField(
                              //         textCon: controller.addressCon,
                              //         hintText: 'Enter Your Address',
                              //         height: 40.h,
                              //         textAlign: TextAlign.end,
                              //         width: Get.width * 0.8,
                              //       )
                              //     : null,
                              value: controller.user.address,
                            ),
                            InfoRow(
                              label: 'Account Created',
                              value: controller.user.createdAt,
                            ),
                          ],
                        ),
                      ),
                    ),
                    addH(20),
                    // Account Information Card
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CustomImg(
                            imgUrl: controller.user.userQrCode,
                          ),
                        ),
                      ),
                    ),
                    addH(24),
                    // Obx(() {
                    // if (controller.editingFlag.value) {
                    //   return CustomBtn(
                    //     btnTxt: 'Save Changes',
                    //     onPressedFn: () => controller.saveChanges(),
                    //   );
                    // } else { return
                    CustomBtn(
                      btnTxt: 'Logout',
                      btnIcon: 'logout',
                      btnColor: Colors.red,
                      onPressedFn: () => AwesomeDialog(
                        context: Get.context!,
                        dialogType: DialogType.warning,
                        title: 'Logout',
                        desc: 'Are you sure you want to logout?',
                        btnCancelOnPress: () => Get.back(),
                        btnOkOnPress: () => controller.logout(),
                      ).show(),
                    ),
                    //; }
                    // }),
                    addH(20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showImgDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Methods.buildDPAlertDialog(
          onPressedFn: pickImage,
          ctx: context,
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  Future<void> pickImage(galleryFlag) async {
    XFile? image;
    try {
      if (galleryFlag) {
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxHeight: 800,
          maxWidth: 600,
        );
      }
      if (image == null) return;
      controller.selectedDP = image;
      controller.uploadImage();
    } on PlatformException catch (e) {
      // showing error
      Get.snackbar(
        'Error Occured!',
        'Failed to pick image: $e',
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 300),
      );
    }
  }
}
