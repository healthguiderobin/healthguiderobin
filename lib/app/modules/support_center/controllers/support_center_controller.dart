import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../data/prefs.dart';
import '../../../data/strings.dart';
import '../../../models/issue.dart';
import '../../../models/user.dart';
import '../../../utils/methods.dart';

class SupportCenterController extends GetxController {
  final titleCon = TextEditingController();
  final bodyCon = TextEditingController();

  late UserModel user;
  final RxBool issuesLF = true.obs;
  final RxBool sheetVisible = true.obs;

  final RxList issueList = [].obs;

  ScrollController scrollCon = ScrollController();

  // pagination
  final int pageSize = 20;
  DocumentSnapshot? lastDoc;
  RxBool hasMoreData = true.obs;
  RxBool isLoadingMore = false.obs;

  @override
  void onInit() {
    super.onInit();

    scrollCon.addListener(onScroll);
    user = Preference.getUserDetails();
    fetchIssues();
  }

  void onScroll() {
    ScrollDirection scrollDir = scrollCon.position.userScrollDirection;
    if (scrollDir == ScrollDirection.reverse) {
      if (sheetVisible.value) {
        sheetVisible.value = false;
      }
    } else if (scrollDir == ScrollDirection.forward) {
      if (!sheetVisible.value) {
        sheetVisible.value = true;
      }
    }
  }

  void fetchIssues({
    bool isNextPage = false,
  }) async {
    if (!isNextPage) {
      lastDoc = null;
      issueList.clear();
      hasMoreData.value = true;
    } else {
      isLoadingMore.value = true;
    }

    issuesLF.value = true;
    final ins = FirebaseFirestore.instance;

    try {
      final issuesRef = ins.collection(
        AppStrings.kIssues,
      );
      Query query = issuesRef.limit(pageSize);

      query = query.orderBy(
        AppStrings.kCreatedAt,
        descending: true,
      );

      if (isNextPage && lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }

      final querySS = await query.get() as QuerySnapshot<Map<String, dynamic>>;

      if (querySS.docs.isNotEmpty) {
        lastDoc = querySS.docs.last;
        issueList.addAll(querySS.docs.map((doc) {
          return IssueModel.fromJson(doc.data());
        }).toList());
      }
      hasMoreData.value = querySS.docs.length == pageSize;
    } finally {
      issuesLF.value = false;
      isLoadingMore.value = false;
    }
  }

  void submitIssue() async {
    Methods.showLoading();
    try {
      final ins = FirebaseFirestore.instance;
      final collection = ins.collection(
        AppStrings.kIssues,
      );
      final docRef = collection.doc();
      await docRef.set(
        IssueModel(
          issueId: docRef.id,
          title: titleCon.text,
          body: bodyCon.text,
          createdAt: FieldValue.serverTimestamp(),
          response: '',
          respondedAt: null,
          userId: user.userId,
          userName: user.name,
          userImage: user.photoURL,
          userPhone: user.phoneNumber,
        ).toJson(),
      );
      titleCon.clear();
      bodyCon.clear();
      Methods.showSnackbar(
        successFlag: true,
        title: 'Issue Submitted!',
        msg: 'Your issue has been submitted successfully.',
      );
      fetchIssues();
    } finally {
      Methods.hideLoading();
    }
  }
}
