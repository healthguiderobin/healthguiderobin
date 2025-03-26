import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/prefs.dart';
import '../../../data/strings.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/methods.dart';

class LoginController extends GetxController {
  final emailCon = TextEditingController();
  final passCon = TextEditingController();

  late UserModel userModel;

  RxBool rememberMe = false.obs;
  String deviceId = '';

  @override
  void onInit() {
    super.onInit();
    emailCon.text = 'robin@healthguiderobin.com';
    if (Preference.getRememberMeFlag()) {
      emailCon.text = Preference.getLoginEmail();
      passCon.text = Preference.getLoginPass();
      rememberMe.value = true;
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailCon.dispose();
    passCon.dispose();
  }

  void loginUser() async {
    Methods.showLoading();
    try {
      final ins = FirebaseAuth.instance;
      UserCredential userCredential = await ins.signInWithEmailAndPassword(
        email: emailCon.text,
        password: passCon.text,
      );
      User? usr = userCredential.user;
      if (usr != null) {
        log("✅ User signed in successfully. ✅");
        userModel = await getUserInfo(usr);
        setUserAndGoHome();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        log('Wrong password provided.');
        Methods.showSnackbar(
          title: 'Wrong password!',
          msg:
              'Please enter a valid password. If you have forgotten your password, please reset it.',
        );
      } else if (e.code == 'invalid-credential') {
        Methods.showSnackbar(
          title: 'Invalid credential',
          msg: "Please enter your email and password correctly.",
        );
      } else {
        Methods.showSnackbar(
          title: 'Login failed!',
          msg: 'Due to some error, login failed. Please try again later.',
        );
      }
    } finally {
      Methods.hideLoading();
    }
  }

  Future<UserModel> getUserInfo(User user) async {
    deviceId = await Methods.getDeviceId();
    final ins = FirebaseFirestore.instance;
    final usrColl = ins.collection(AppStrings.kUsers);
    final docRef = usrColl.doc(user.uid);
    final userDoc = await docRef.get();
    if (userDoc.exists) {
      log('✅ User details found in firestore ✅');
      log(userDoc.data().toString());
      return UserModel.fromJson(
        userDoc.data() as Map<String, dynamic>,
      );
    } else {
      log('❌ User not found in firestore ❌');
      String fToken = await FirebaseMessaging.instance.getToken() ?? '';
      UserModel usrM = UserModel(
        userId: user.uid,
        deviceId: deviceId,
        email: user.email ?? '',
        name: user.displayName ?? '',
        phoneNumber: user.phoneNumber ?? '',
        photoURL: user.photoURL ?? '',
        address: '',
        userQrCode: '',
        fbToken: fToken,
        createdAt: await fetchServerTimestamp(),
      );
      await docRef.set(usrM.toJson());
      log("✅ User added to Firestore. ✅");
      return usrM;
    }
  }

  Future<String> fetchServerTimestamp() async {
    final tempDoc = FirebaseFirestore.instance.collection('temp').doc();
    await tempDoc.set({'createdAt': FieldValue.serverTimestamp()});
    final snapshot = await tempDoc.get();
    final serverTimestamp = snapshot.data()?['createdAt'] as Timestamp?;
    await tempDoc.delete();
    return formatDateTime(
      serverTimestamp?.toDate() ?? DateTime.now(),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final formattedDate = DateFormat('MMMM d, y').format(dateTime);
    final formattedTime = DateFormat('h:mm:ss a').format(dateTime);
    return '$formattedDate at $formattedTime';
  }

  void setUserAndGoHome() async {
    Preference.setLoggedInFlag(true);
    Preference.storeUserDetails(userModel);
    Get.offAllNamed(Routes.HOME);
  }
}
