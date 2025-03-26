import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../../../data/clrs.dart';
import '../controllers/home_controller.dart';
import '../screens/doctors/doctors_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/hospitals/hospitals_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/qr_scanner/qr_scanner.dart';
import '../widgets/nav_item.dart';
import 'drawer_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: controller.zdCon,
      angle: -12,
      borderRadius: 24.0,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      slideHeight: 80.h,
      slideWidth: Get.width * 0.85,
      // menuBackgroundColor: Colors.transparent,
      // menuScreenOverlayColor: AppClrs.kFFFBF4,
      menuBackgroundColor: AppClrs.kSecondaryClr,
      // menuScreenOverlayColor: AppClrs.kPrimaryClr,
      menuScreen: DrawerView(),
      mainScreen: UpgradeAlert(
        barrierDismissible: false,
        showIgnore: false,
        showLater: false,
        upgrader: Upgrader(
          debugDisplayAlways: false,
          durationUntilAlertAgain: Duration(seconds: 10),
        ),
        // enable this for Android
        dialogStyle: UpgradeDialogStyle.material,
        // enable this for iOS
        // dialogStyle: UpgradeDialogStyle.cupertino,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: AppClrs.kPrimaryClr,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: DrawerView(),
            body: Obx(() {
              switch (controller.sNavIndex.value) {
                case 0:
                  return HomeScreen(
                    navigatingFn: (value) => controller.sNavIndex(value),
                  );
                case 1:
                  return DoctorsScreen();
                case 2:
                  return QRScannerScreen();
                case 3:
                  return HospitalsScreen();
                case 4:
                  return ProfileScreen(
                    navigatingFn: (value) => controller.sNavIndex(value),
                  );
                default:
                  return Container(
                    child: Center(
                      child: Text(
                        'No view available now!',
                      ),
                    ),
                  );
              }
            }),
            bottomNavigationBar: Obx(
              () => CurvedNavigationBar(
                height: 65.h,
                maxWidth: Get.width,
                color: AppClrs.kPrimaryClr,
                backgroundColor: AppClrs.kBackgroundClr,
                index: controller.sNavIndex.value,
                items: <Widget>[
                  NavItem(
                    icon: 'home',
                    title: 'Home',
                    isSelected: controller.sNavIndex.value == 0,
                  ),
                  NavItem(
                    icon: 'doctor',
                    title: 'Doctors',
                    isSelected: controller.sNavIndex.value == 1,
                  ),
                  NavItem(
                    icon: 'camera',
                    title: 'Scan',
                    isSelected: controller.sNavIndex.value == 2,
                  ),
                  NavItem(
                    icon: 'hospital',
                    title: 'Hospitals',
                    isSelected: controller.sNavIndex.value == 3,
                  ),
                  NavItem(
                    icon: 'profile',
                    title: 'Profile',
                    isSelected: controller.sNavIndex.value == 4,
                  ),
                ],
                onTap: (index) async {
                  controller.sNavIndex.value = index;
                  // if (index == 1) {
                  //   // If scan button is tapped
                  //   final result = await Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => QRScannerScreen(),
                  //     ),
                  //   );

                  //   if (result != null) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(content: Text("Scanned: $result")),
                  //     );
                  //   }
                  // }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
