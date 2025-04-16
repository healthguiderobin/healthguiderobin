import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../data/clrs.dart';
import '../../../data/prefs.dart';
import '../../../designs/custom_btn.dart';
import '../../../designs/custom_img.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/methods.dart';
import '../../../widgets/helper.dart';
import '../controllers/profile_controller.dart';

class DrawerView extends StatefulWidget {
  DrawerView({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  final controller = Get.find<ProfileController>();
  final List<String> _menuIcons = [
    'assets/svgs/about.svg',
    'assets/svgs/support.svg',
    'assets/svgs/question.svg',
    'assets/svgs/privacy.svg',
    'assets/svgs/terms.svg',
  ];
  final List<VoidCallback> _menuFns = [
    () => Get.toNamed(Routes.ABOUT_US),
    () => Get.toNamed(Routes.SUPPORT_CENTER),
    () => Get.toNamed(Routes.FAQ),
    () => Get.toNamed(Routes.PRIVACY),
    () => Get.toNamed(Routes.TERMS),
  ];

  final List<String> _menuItems = const [
    'About Us',
    'Support Center',
    'Frequently Asked Questions',
    'Privacy Policy',
    'Terms and Conditions',
  ];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClrs.kPrimaryClr,
      body: Container(
        width: 360.w,
        padding: EdgeInsets.only(
          left: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addH(105.h),
            SizedBox(
              height: 60.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: () => Methods.openImageView(
                      context,
                      imgUrl: controller.dpLink.value,
                    ),
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: CustomImg(
                          imgUrl: controller.user.photoURL,
                          imgFit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  addW(10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        controller.user.name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: AutoSizeText(
                          controller.user.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            addH(80.h),
            // Menu Items
            Expanded(
              child: Center(
                child: ListView.builder(
                  itemCount: _menuItems.length,
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 25.h),
                      child: InkWell(
                        onTap: _menuFns[index],
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                _menuIcons[index],
                                width: 22.w,
                                height: 22.h,
                                colorFilter: ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              addW(10.w),
                              Text(
                                _menuItems[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            addH(20.h),
            CustomBtn(
              onPressedFn: () => AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                title: 'Logout',
                desc: 'Are you sure want to logout?',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  // AuthService.signOut();
                  Preference.logoutFn();
                  Get.offAllNamed(Routes.LOGIN);
                },
              ).show(),
              btnTxt: 'Logout',
              txtColor: Colors.white,
              txtWeight: FontWeight.w400,
              btnIcon: 'logout',
              btnColor: AppClrs.kAccentClr,
              btnSize: Size(150.w, 56.h),
            ),
            addH(50.h),
          ],
        ),
      ),
    );
  }
}
