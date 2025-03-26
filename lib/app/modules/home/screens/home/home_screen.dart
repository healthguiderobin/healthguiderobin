import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../data/clrs.dart';
import '../../../../designs/custom_img.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../widgets/helper.dart';
import '../../controllers/home_controller.dart';
import 'banner_slider.dart';
import 'post_item.dart';
import 'top_bar.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int) navigatingFn;
  const HomeScreen({
    super.key,
    required this.navigatingFn,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController hCon = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    if (hCon.bannerList.isEmpty) {
      hCon.fetchBanners();
    }
    if (hCon.postList.isEmpty) {
      hCon.fetchPosts();
    }
    // if (hCon.categoryList.isEmpty) {
    //   hCon.fetchCategories();
    // }
    // if (hCon.highlights.isEmpty) {
    //   hCon.fetchHighlights();
    // }
  }

  @override
  Widget build(BuildContext context) {
    hCon.fetchPosts();
    return SafeArea(
      child: Column(
        children: [
          TopBar(
            controller: hCon,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                hCon.fetchBanners();
                // hCon.fetchCategories();
                // hCon.fetchTopPosts();
                // hCon.fetchHighlights();
              },
              color: AppClrs.kAccentClr,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      if (hCon.bannersLF.value) {
                        return Shimmer.fromColors(
                          child: Container(
                            width: Get.width,
                            height: 230.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20.r),
                              ),
                            ),
                          ),
                          baseColor: AppClrs.kBackgroundClr,
                          highlightColor: AppClrs.kAccentClr,
                        );
                      } else {
                        if (hCon.bannerList.isEmpty) {
                          return Container(
                            height: 230.h,
                            decoration: BoxDecoration(
                              color: AppClrs.kPrimaryClr,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20.r),
                              ),
                            ),
                          );
                        } else {
                          return BannerSlider(
                            banners: hCon.bannerList,
                          );
                        }
                      }
                    }),
                    addH(10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: Column(
                        children: [
                          Obx(() {
                            if (hCon.postsLF.value) {
                              return Padding(
                                padding: EdgeInsets.only(top: 200.h),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              if (hCon.postList.isEmpty) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 200.h),
                                  child: Center(
                                    child: TitleTxt(
                                      title: 'No Posts Available',
                                    ),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: hCon.postList.length,
                                  itemBuilder: (context, index) {
                                    return PostItem(
                                      post: hCon.postList[index],
                                    );
                                  },
                                );
                              }
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
