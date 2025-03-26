import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final void Function(int) navigatingFn;
  const ProfileScreen({
    super.key,
    required this.navigatingFn,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final pCon = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
