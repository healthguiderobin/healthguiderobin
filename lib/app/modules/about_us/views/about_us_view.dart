import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/clrs.dart';
import '../../../data/strings.dart';
import '../../../widgets/body_widget.dart';
import '../../../widgets/helper.dart';
import '../controllers/about_us_controller.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        title: 'About Us',
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // introduction
                Text(
                  'WHAT IS IT?',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppClrs.kAccentClr,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                addH(10.h),
                Text(
                  AppStrings.kAboutUs1,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                addH(5.h),
                Text(
                  AppStrings.kAboutUs2,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                addH(20.h),
                Text(
                  AppStrings.kServiceTitle,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppClrs.kAccentClr,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                addH(10.h),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.services.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          controller.services[index],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                addH(20.h),
                Text(
                  AppStrings.kContactUsText,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppClrs.kAccentClr,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                addH(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 10,
                      child: AutoSizeText(
                        'Email: healthguiderobin@gmail.com',
                        maxLines: 1,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    addW(10.w),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () => Clipboard.setData(
                          ClipboardData(
                            text: 'healthguiderobin@gmail.com',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                addH(20.h),
                Row(
                  children: [
                    Flexible(
                      flex: 10,
                      child: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 10,
                        color: Colors.black,
                      ),
                    ),
                    Flexible(
                      flex: 10,
                      child: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                addH(20.h),
                // credits
                Text(
                  'Credits',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppClrs.kAccentClr,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                addH(10.h),
                // rich text with hyperlinks
                RichText(
                  text: TextSpan(
                    text: "Icons are provided by ",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "Font Awesome",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await UrlLauncher.launchUrl(
                              Uri.parse('https://fontawesome.com/'),
                              mode: UrlLauncher.LaunchMode.externalApplication,
                            );
                          },
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: " under the ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "MIT License.",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await UrlLauncher.launchUrl(
                              Uri.parse('https://opensource.org/license/MIT'),
                              mode: UrlLauncher.LaunchMode.externalApplication,
                            );
                          },
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                addH(10.h),
                // rich text with hyperlinks
                RichText(
                  text: TextSpan(
                    text: "Some animations on this app are sourced from ",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "LottieFiles",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await UrlLauncher.launchUrl(
                              Uri.parse('https://lottiefiles.com/'),
                              mode: UrlLauncher.LaunchMode.externalApplication,
                            );
                          },
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text:
                            " created by talented contributors from the Lottie community.",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                addH(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
