import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/body_widget.dart';
import '../controllers/terms_controller.dart';

class TermsView extends GetView<TermsController> {
  const TermsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        title: 'Terms and Conditions',
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
