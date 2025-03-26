import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../designs/custom_img.dart';
import '../../../utils/methods.dart';

class CustomSlider extends StatefulWidget {
  final List<String> imgList;
  const CustomSlider({
    super.key,
    required this.imgList,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 400.h,
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Stack(
            children: [
              SizedBox(
                child: CarouselSlider(
                  options: CarouselOptions(height: 400.0),
                  items: widget.imgList.map(
                    (item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: CustomImg(
                                imgUrl: item,
                                imgHeight: 400.h,
                                imgFit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: InkWell(
                                onTap: () => Methods.openImageView(
                                  context,
                                  imgUrl: item,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey.shade100.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: const Icon(
                                    Icons.zoom_out_map,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
