import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/clrs.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/helper.dart';
import '../../controllers/doctors_controller.dart';
import 'speciality_card.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final hCon = Get.find<DoctorsController>();

  @override
  Widget build(BuildContext context) {
    // hCon.fetchSpecialities();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            children: [
              addH(20.h),
              Text(
                'Select a Speciality',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppClrs.kPrimaryClr,
                ),
              ),
              Divider(
                thickness: 1,
                color: AppClrs.kPrimaryClr,
              ),
              addH(10.h),
              Expanded(
                child: Obx(() {
                  if (hCon.specialitiesLF.value) {
                    return Padding(
                      padding: EdgeInsets.only(top: 200.h),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    if (hCon.specialityList.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 200.h),
                        child: Center(
                          child: Text(
                            'No Specialities Available',
                          ),
                        ),
                      );
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 165.h,
                        ),
                        itemCount: hCon.specialityList.length,
                        // itemCount: 20,
                        itemBuilder: (context, index) {
                          return SpecialityCard(
                            logo: hCon.specialityList[index].logo,
                            title: hCon.specialityList[index].name,
                            onTapFn: () => Get.toNamed(
                              Routes.DOCTOR_LIST,
                              arguments: hCon.specialityList[index],
                            ),
                          );
                        },
                      );
                    }
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
