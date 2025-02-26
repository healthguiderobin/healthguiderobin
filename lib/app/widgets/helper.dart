import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Widget addH(double h) => SizedBox(height: h);
Widget addW(double w) => SizedBox(width: w);

Widget errorScreen(details) => Material(
      color: Colors.green.shade200,
      child: Scaffold(
        backgroundColor: Colors.green.shade200,
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          leading: Get.previousRoute.isNotEmpty
              ? IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                )
              : null,
          title: const Text('Error Occured!'),
        ),
        body: Center(
          child: Text(
            details.exception.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
