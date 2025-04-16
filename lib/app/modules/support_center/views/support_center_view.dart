import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/clrs.dart';
import '../../../designs/custom_btn.dart';
import '../../../models/issue.dart';
import '../../../utils/methods.dart';
import '../../../widgets/body_widget.dart';
import '../../../widgets/helper.dart';
import '../controllers/support_center_controller.dart';
import 'issue_submit_sheet.dart';

class SupportCenterView extends GetView<SupportCenterController> {
  const SupportCenterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        title: 'Support Center',
        child: Expanded(
          child: Obx(() {
            if (controller.issuesLF.value && controller.issueList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (controller.issueList.isEmpty) {
                return const Center(
                  child: Text('No issues found'),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    controller.fetchIssues();
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.issueList.length + 1,
                    padding: EdgeInsets.only(bottom: 300.w),
                    controller: controller.scrollCon,
                    itemBuilder: (context, index) {
                      if (index == controller.issueList.length) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Obx(() {
                            if (controller.isLoadingMore.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (controller.hasMoreData.value) {
                                return Center(
                                  child: CustomBtn(
                                    btnTxt: 'Load More',
                                    btnSize: Size(150.w, 50.h),
                                    onPressedFn: () {
                                      controller.fetchIssues(
                                        isNextPage: true,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                    'These are all the issues!',
                                  ),
                                );
                              }
                            }
                          }),
                        );
                      }
                      return IssueCard(
                        issue: controller.issueList[index],
                      );
                    },
                  ),
                );
              }
            }
          }),
        ),
      ),
      floatingActionButton: Obx(() {
        return AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          width: Get.width,
          height: controller.sheetVisible.value ? 300.h : 0,
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: AppClrs.kWhiteClr,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.r,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: IssueSubmitSheet(),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class IssueCard extends StatelessWidget {
  final IssueModel issue;

  const IssueCard({
    Key? key,
    required this.issue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.r,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: NetworkImage(issue.userImage),
                ),
                addW(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        issue.userName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Methods.formatTimestamp(issue.createdAt),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            addH(12),
            Text(
              issue.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            addH(8),
            Text(
              issue.body,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            addH(10),
            if (issue.response.isNotEmpty) ...[
              Divider(
                thickness: 1.r,
                color: Colors.grey[300],
              ),
              addH(10),
              Row(
                children: [
                  Icon(
                    Icons.reply,
                    size: 16.r,
                    color: Colors.green[600],
                  ),
                  addW(8),
                  Text(
                    'Response',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[600],
                    ),
                  ),
                ],
              ),
              addH(8),
              Text(
                issue.response,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[800],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              addH(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    Methods.formatTimestamp(issue.respondedAt),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
