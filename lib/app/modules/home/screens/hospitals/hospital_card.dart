import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:get/get.dart';

import '../../../../data/clrs.dart';
import '../../../../designs/custom_img.dart';
import '../../../../models/hospital.dart';
import '../../../../utils/methods.dart';
import '../../../../widgets/helper.dart';

class HospitalCard extends StatelessWidget {
  final HospitalModel hospital;
  final VoidCallback? onTap;

  const HospitalCard({
    Key? key,
    required this.hospital,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width,
              height: 200.h,
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.r),
                    ),
                    child: CustomImg(
                      imgUrl: hospital.image,
                      imgWidth: Get.width,
                      imgHeight: 200.h,
                      imgFit: BoxFit.cover,
                    ),
                  ),
                  // zoom icon
                  InkWell(
                    onTap: () => Methods.openImageView(
                      context,
                      imgUrl: hospital.image,
                    ),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: Icon(
                        Icons.zoom_out_map,
                        size: 20.sp,
                        color: AppClrs.kWhiteClr,
                      ),
                    ),
                  ),
                  // discount percentage
                  Positioned(
                    right: 0.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppClrs.kAccentClr,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        '${hospital.discountPrcntg} Off',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppClrs.kWhiteClr,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            addH(10.h),
            Text(
              hospital.name,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            addH(10.h),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 25.sp,
                ),
                addW(10.w),
                Expanded(
                  child: Text(
                    hospital.address,
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
            addH(8.h),
            InkWell(
              onTap: () => Clipboard.setData(
                ClipboardData(text: hospital.contact),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.smartphone,
                    size: 25.sp,
                  ),
                  addW(10.w),
                  Expanded(
                    child: Text(
                      hospital.contact,
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      UrlLauncher.launchUrl(
                        Uri.parse('tel:${hospital.contact}'),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: AppClrs.kPrimaryClr,
                      child: Icon(
                        Icons.phone,
                        size: 20.sp,
                        color: AppClrs.kWhiteClr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
