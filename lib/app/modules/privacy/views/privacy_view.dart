import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/body_widget.dart';
import '../controllers/privacy_controller.dart';

class PrivacyView extends GetView<PrivacyController> {
  const PrivacyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        title: 'Privacy Policy',
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
