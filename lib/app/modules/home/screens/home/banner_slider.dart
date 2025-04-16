import 'package:bordered_text/bordered_text.dart';
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
            left: widget.banners.length * 22.w,
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
                  BorderedText(
                    strokeWidth: 2.0,
                    child: Text(
                      widget.banners[activeIndex].title,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  addH(5.h),
                  BorderedText(
                    strokeWidth: 1.0,
                    child: Text(
                      widget.banners[activeIndex].subtitle,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
                dotWidth: 14.w,
                dotHeight: 14.h,
                dotColor: AppClrs.kAccentClr,
                activeDotColor: AppClrs.kPrimaryClr,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
