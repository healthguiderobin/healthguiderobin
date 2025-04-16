import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/clrs.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/body_widget.dart';
import '../../../../widgets/helper.dart';
import '../../controllers/doctors_controller.dart';
import 'speciality_card.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final controller = Get.find<DoctorsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        noBack: true,
        title: 'Select a Speciality',
        child: Expanded(
          child: Obx(() {
            if (controller.specialitiesLF.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (controller.specialityList.isEmpty) {
                return Center(
                  child: Text(
                    'No Specialities Available',
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () async => controller.fetchSpecialities(),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 165.h,
                    ),
                    itemCount: controller.specialityList.length,
                    itemBuilder: (context, index) {
                      return SpecialityCard(
                        logo: controller.specialityList[index].logo,
                        title: controller.specialityList[index].name,
                        onTapFn: () => Get.toNamed(
                          Routes.DOCTOR_LIST,
                          arguments: controller.specialityList[index],
                        ),
                      );
                    },
                  ),
                );
              }
            }
          }),
        ),
      ),
    );
  }
}
