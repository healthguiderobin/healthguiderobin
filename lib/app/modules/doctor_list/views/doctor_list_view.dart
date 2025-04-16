import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/clrs.dart';
import '../../../widgets/body_widget.dart';
import '../../../widgets/helper.dart';
import '../controllers/doctor_list_controller.dart';
import '../widgets/doctor_card.dart';

class DoctorListView extends GetView<DoctorListController> {
  const DoctorListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        title: 'Available Doctors',
        child: Expanded(
          child: Obx(() {
            if (controller.doctorsLF.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (controller.doctorList.isEmpty) {
                return Center(
                  child: Text(
                    'No Doctors Found!',
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.doctorList.length,
                  itemBuilder: (context, index) {
                    return DoctorCard(
                      doctor: controller.doctorList[index],
                    );
                  },
                );
              }
            }
          }),
        ),
      ),
    );
  }
}
