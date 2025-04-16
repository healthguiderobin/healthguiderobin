import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/prefs.dart';
import '../../../data/strings.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';
import '../../../services/base_client.dart';
import '../../../utils/methods.dart';

class ProfileController extends GetxController {
  late UserModel user;
  final nameCon = TextEditingController();
  final phoneCon = TextEditingController();
  final addressCon = TextEditingController();

  late XFile selectedDP;
  final RxString dpLink = ''.obs;

  // RxBool editingFlag = false.obs;

  @override
  void onInit() {
    super.onInit();
    user = Preference.getUserDetails();
    dpLink.value = user.photoURL;
    nameCon.text = user.name;
    phoneCon.text = user.phoneNumber;
    addressCon.text = user.address;
  }

  void uploadImage() async {
    Methods.showLoading();
    try {
      String response = await BaseClient.uploadImage(
        imgPath: selectedDP.path,
      );
      dpLink.value = response;
    } finally {
      if (dpLink.isNotEmpty) {
        Methods.showSnackbar(
          duration: 3,
          successFlag: true,
          title: 'Image Upload Completed!',
          msg: 'Please save your changes to update your profile.',
        );
      } else {
        Methods.showSnackbar(
          title: 'Image Upload Failed!',
          msg: 'Due to some reason, image upload failed. Please try again.',
        );
      }
      Methods.hideLoading();
    }
  }

  // void saveChanges() async {
  //   Methods.showLoading();
  //   try {
  //     final instance = FirebaseFirestore.instance;
  //     final coll = instance.collection(AppStrings.kUsers);
  //     DocumentReference userRef = coll.doc(user.userId);
  //     await userRef.update({
  //       'displayName': nameCon.text.trim(),
  //       'phoneNumber': phoneCon.text.trim(),
  //       'photoURL': dpLink.value,
  //       'address': addressCon.text.trim(),
  //       'updatedAt': FieldValue.serverTimestamp(),
  //     });
  //     var usrInfo = await getUserInfo(user.userId);
  //     user = UserModel.fromJson(usrInfo);
  //     Preference.setUserDetails(user);
  //     Preference.setUserDP(user.photoURL);
  //     Methods.showSnackbar(
  //       duration: 3,
  //       successFlag: true,
  //       title: 'Update Successful!',
  //       msg: 'Your profile has been updated successfully.',
  //     );
  //     editingFlag.value = false;
  //     editingFlag.refresh();
  //   } catch (e) {
  //     Methods.showSnackbar(
  //       title: 'Update Failed!',
  //       msg: 'Due to some error, update failed. Please try again later.',
  //     );
  //   } finally {
  //     Methods.hideLoading();
  //   }
  // }

  // Future<Map<String, dynamic>> getUserInfo(String uid) async {
  //   final coll = FirebaseFirestore.instance.collection(
  //     AppStrings.kUsers,
  //   );
  //   DocumentSnapshot userDoc = await coll.doc(uid).get();
  //   if (userDoc.exists) {
  //     return userDoc.data() as Map<String, dynamic>;
  //   } else {
  //     return {};
  //   }
  // }

  void logout() async {
    Methods.showLoading();
    try {
      await FirebaseAuth.instance.signOut();
      Preference.setLoggedInFlag(false);
      Preference.logoutFn();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      // print('Error while logging out: $e');
      Methods.showSnackbar(
        title: 'Logout failed!',
        msg: 'Due to some error, logout failed. Please try again later.',
      );
    } finally {
      Methods.hideLoading();
    }
  }

  void deleteUser() async {
    Methods.showLoading();
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        String? uid = user.uid;

        final ins = FirebaseFirestore.instance;
        final userColl = ins.collection(AppStrings.kUsers);
        final userDoc = await userColl.doc(uid).get();

        if (userDoc.exists) {
          await userColl.doc(uid).delete();
          await user.delete();
          // print("✅ User account deleted successfully. ✅");
          Methods.showSnackbar(
            successFlag: true,
            title: 'Delete Successful!',
            msg: 'Your account has been deleted successfully.',
          );
          Get.offAllNamed(Routes.LOGIN);
        } else {
          return;
        }
      } else {
        // print("❌ No user is signed in. ❌");
        Methods.showSnackbar(
          title: 'Delete Failed!',
          msg:
              'Due to some error, account deletion failed. Please try again later.',
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // print("The user must reauthenticate before deleting their account.");
        Methods.showSnackbar(
          title: 'Reauthentication Required',
          msg: 'Please reauthenticate to delete your account.',
        );
        // Handle reauthentication here
      } else {
        // print("Error: ${e.message}");
        Methods.showSnackbar(
          title: 'Delete Failed!',
          msg:
              'Due to some error, account deletion failed. Please try again later.',
        );
      }
    } catch (e) {
      // print("An unexpected error occurred: $e");
      Methods.showSnackbar(
        title: 'Delete Failed!',
        msg:
            'Due to some error, account deletion failed. Please try again later.',
      );
    } finally {
      Methods.hideLoading();
    }
  }
}
