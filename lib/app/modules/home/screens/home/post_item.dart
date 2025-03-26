import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/clrs.dart';
import '../../../../designs/custom_img.dart';
import '../../../../models/post.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/video.dart';
import '../../../../utils/methods.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../widgets/helper.dart';

class PostItem extends StatelessWidget {
  final PostModel post;
  const PostItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppClrs.kPrimaryClr,
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // user image, name and post time
            Row(
              children: [
                // user image
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: AppClrs.kPrimaryClr,
                ),
                addW(10.w),
                // user name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // user name
                    TitleTxt(
                      title: 'Admin',
                      fSize: 16.sp,
                    ),
                    addH(5.h),
                    // post time
                    TitleTxt(
                      title: post.createdAt.toDate().toString(),
                      fSize: 14.sp,
                    ),
                  ],
                ),
              ],
            ),
            addH(10.h),
            // post text
            TitleTxt(
              title: post.title,
              fSize: 16.sp,
            ),
            addH(10.h),
            // post image
            InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.POST_DETAILS,
                  arguments: post,
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // blur image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CustomImg(
                      imgUrl: post.videoThumb,
                      imgWidth: Get.width,
                      imgHeight: 200.h,
                      imgFit: BoxFit.cover,
                    ),
                  ),
                  // play button
                  Center(
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: AppClrs.kPrimaryClr,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            addH(5.h),
            Divider(
              thickness: 0.5.w,
              color: AppClrs.kPrimaryClr,
            ),
            addH(5.h),
            // image gallery
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: post.imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 10.w,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: InkWell(
                        onTap: () => Methods.openImageView(
                          context,
                          imgUrl: post.imageList[index],
                        ),
                        child: CustomImg(
                          imgUrl: post.imageList[index],
                          imgWidth: 100.w,
                          imgHeight: 100.h,
                          imgFit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            addH(10.h),
          ],
        ),
      ),
    );
  }
}
