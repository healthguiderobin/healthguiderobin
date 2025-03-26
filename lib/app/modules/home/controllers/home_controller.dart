import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../../data/strings.dart';
import '../../../models/banner.dart';
import '../../../models/post.dart';
import '../../../utils/methods.dart';

class HomeController extends GetxController {
  final zdCon = ZoomDrawerController();

  RxInt sNavIndex = 0.obs;

  RxBool bannersLF = false.obs;
  RxBool postsLF = false.obs;

  List<BannerModel> bannerList = [];
  List<PostModel> postList = [];

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
    fetchPosts();
  }

  void fetchBanners() async {
    bannersLF.value = true;
    try {
      final collection = FirebaseFirestore.instance.collection(
        AppStrings.kBanners,
      );
      try {
        final querySS = await collection.get();
        bannerList = querySS.docs.map((doc) {
          return BannerModel.fromJson(doc.data());
        }).toList();
      } catch (e) {
        Methods.showSnackbar(
          title: 'Failed to fetch banners!',
          msg: 'Something went wrong. Please try again later.',
        );
      }
    } finally {
      bannersLF.value = false;
    }
  }

  void fetchPosts() async {
    postsLF.value = true;
    try {
      final collection = FirebaseFirestore.instance.collection(
        AppStrings.kPosts,
      );
      try {
        final querySS = await collection.get();
        postList = querySS.docs.map((doc) {
          return PostModel.fromJson(doc.data());
        }).toList();
      } catch (e) {
        Methods.showSnackbar(
          title: 'Failed to fetch posts!',
          msg: 'Something went wrong. Please try again later.',
        );
      }
    } finally {
      postsLF.value = false;
    }
  }
}
