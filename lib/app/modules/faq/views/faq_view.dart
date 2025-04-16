import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/body_widget.dart';
import '../controllers/faq_controller.dart';
import 'faq_card.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        title: 'Frequently Asked Questions',
        child: Expanded(
          child: Obx(() {
            if (controller.bannersLF.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (controller.faqList.isEmpty) {
                return const Center(
                  child: Text('No FAQs found'),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.faqList.length,
                  itemBuilder: (context, index) {
                    return FAQCard(
                      faq: controller.faqList[index],
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
