import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../data/clrs.dart';
import '../../../../designs/custom_img.dart';
import '../../../../models/banner.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../widgets/helper.dart';

class BannerSlider extends StatefulWidget {
  final List<BannerModel> banners;
  const BannerSlider({
    super.key,
    required this.banners,
  });

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 240.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.r),
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 240.h,
              autoPlay: true,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              autoPlayAnimationDuration: const Duration(
                milliseconds: 1500,
              ),
              onPageChanged: (index, reason) {
                setState(() => activeIndex = index);
              },
            ),
            items: widget.banners.map((item) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
                child: CustomImg(
                  imgUrl: item.image,
                  imgWidth: Get.width,
                  imgFit: BoxFit.cover,
                ),
              );
            }).toList(),
          ),
          Positioned(
            bottom: 10.h,
            right: 10.w,
            child: Container(
              width: Get.width - 100.w,
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTxt(
                    title: widget.banners[activeIndex].title,
                    maxL: 1,
                    fSize: 14.sp,
                    txtClr: Colors.white,
                    fWeight: FontWeight.w600,
                  ),
                  addH(5.h),
                  TitleTxt(
                    title: widget.banners[activeIndex].subtitle,
                    maxL: 1,
                    fSize: 11.sp,
                    txtClr: Colors.white,
                    fWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10.w,
            bottom: 10.h,
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: widget.banners.length,
              effect: WormEffect(
                dotColor: AppClrs.kPrimaryClr,
                activeDotColor: AppClrs.kAccentClr,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
