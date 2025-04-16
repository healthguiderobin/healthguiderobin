import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../designs/custom_img.dart';
import '../../../../widgets/body_widget.dart';
import '../../controllers/hospitals_controller.dart';
import 'hospital_card.dart';

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({super.key});

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  final controller = Get.find<HospitalsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        noBack: true,
        title: 'Hospitals & Diagnostics Centers',
        child: Expanded(
          child: Obx(() {
            if (controller.hospitalsLF.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (controller.hospitalsList.isEmpty) {
                return Center(
                  child: Text(
                    'No Hospitals Available',
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.hospitalsList.length,
                  itemBuilder: (context, index) {
                    return HospitalCard(
                      hospital: controller.hospitalsList[index],
                      onTap: () {
                        // Handle hospital tap if needed
                      },
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
