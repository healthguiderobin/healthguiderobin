import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/doctor_list_controller.dart';

class DoctorListView extends GetView<DoctorListController> {
  const DoctorListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DoctorListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DoctorListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
