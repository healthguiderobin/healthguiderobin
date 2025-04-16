import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../data/clrs.dart';
import '../../../models/chamber.dart';
import '../../../widgets/helper.dart';

class ChamberCard extends StatelessWidget {
  final ChamberModel chamber;
  final VoidCallback? onTap;

  const ChamberCard({
    Key? key,
    required this.chamber,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 8.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    chamber.name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      UrlLauncher.launchUrl(
                        Uri.parse('tel:${chamber.contact}'),
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
              addH(8.h),
              Text(
                chamber.location,
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              addH(8.h),
              Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 20.sp,
                      ),
                      addW(4.w),
                      Text(
                        chamber.timings,
                      ),
                    ],
                  ),
                  addW(16.w),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 20.sp,
                      ),
                      addW(4.w),
                      Text(
                        chamber.days,
                      ),
                    ],
                  ),
                ],
              ),
              addH(8.h),
              InkWell(
                onTap: () => Clipboard.setData(
                  ClipboardData(text: chamber.contact),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.smartphone,
                      size: 20.sp,
                    ),
                    addW(4.w),
                    Expanded(
                      child: Text(
                        chamber.contact,
                      ),
                    ),
                  ],
                ),
              ),
              if (chamber.note.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addH(8.h),
                    Text(
                      'Note:',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      chamber.note,
                      style: TextStyle(
                        color: AppClrs.kAccentClr,
                      ),
                    ),
                  ],
                ),
              if (chamber.exception.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addH(8.h),
                    Text(
                      'Exception:',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      chamber.exception,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
