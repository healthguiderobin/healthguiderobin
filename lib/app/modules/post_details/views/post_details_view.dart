import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../services/video.dart';
import '../../../widgets/body_widget.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/helper.dart';
import '../controllers/post_details_controller.dart';
import 'slider.dart';

class PostDetailsView extends GetView<PostDetailsController> {
  const PostDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        title: 'Post Details',
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.postItem.imageList.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: CustomSlider(
                    imgList: controller.postItem.imageList,
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleTxt(
                      title: controller.postItem.title,
                      maxL: 10,
                    ),
                    addH(10.h),
                    Text(
                      controller.postItem.body,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    addH(10.h),
                    VideoPlayerView(
                      url: controller.postItem.videoLink,
                    ),
                    addH(10.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
