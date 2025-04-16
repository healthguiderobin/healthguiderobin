import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../../data/strings.dart';
import '../../../models/banner.dart';
import '../../../models/post.dart';

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
      final querySS = await collection.get();
      bannerList = querySS.docs.map((doc) {
        return BannerModel.fromJson(doc.data());
      }).toList();
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
      final querySS = await collection.get();
      postList = querySS.docs.map((doc) {
        return PostModel.fromJson(doc.data());
      }).toList();
    } finally {
      postsLF.value = false;
    }
  }
}
