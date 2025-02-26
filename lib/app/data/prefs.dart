import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class Preference {
  static final prefs = GetStorage();
  static const onboardFlag = 'onboardFlag';
  static const loggedInFlag = 'loginFlag';

  static const userDetails = 'userDetails';
  static const userDP = 'userDP';
  static const rememberMeFlag = 'rememberMeFlag';
  static const loginPhoneNoCC = 'loginPhoneNoCC';
  static const loginPhoneNo = 'loginPhoneNo';
  static const loginEmail = 'loginEmail';
  static const loginPass = 'loginPass';
  // show case keys
  static const addQstSC = 'addQstSC';

  // start show case methods

  static bool getAddQstSC() => prefs.read(addQstSC) ?? true;
  static void setAddQstSC(bool value) => prefs.write(addQstSC, value);

  // end of show case methods

  static bool getOnboardFlag() => prefs.read(onboardFlag) ?? false;
  static void setOnboardFlag(bool value) => prefs.write(onboardFlag, value);

  static bool getLoggedInFlag() => prefs.read(loggedInFlag) ?? false;
  static void setLoggedInFlag(bool value) => prefs.write(loggedInFlag, value);

  // // get
  // static UserModel fetchUserDetails() {
  //   var result = prefs.read(userDetails);
  //   return UserModel.fromJson(json.decode(result));
  // }

  // // set
  // static void storeUserDetails(UserModel value) {
  //   prefs.write(userDetails, json.encode(value.toJson()));
  // }

  // get dp
  static String getUserDP() => prefs.read(userDP) ?? '';

  // set dp
  static void setUserDP(String value) => prefs.write(userDP, value);

  // get
  static bool getRememberMeFlag() => prefs.read(rememberMeFlag) ?? false;

  // set
  static void setRememberMeFlag(bool value) =>
      prefs.write(rememberMeFlag, value);

  // get login phone no. cc
  static String getLoginPhoneNoCC() => prefs.read(loginPhoneNoCC) ?? '+971';

  // set login phone no. cc
  static void setLoginPhoneNoCC(String value) =>
      prefs.write(loginPhoneNoCC, value);

  // get login phone no.
  static String getLoginPhoneNo() => prefs.read(loginPhoneNo) ?? '';

  // set login phone no.
  static void setLoginPhoneNo(String value) => prefs.write(loginPhoneNo, value);

  // get login email
  static String getLoginEmail() => prefs.read(loginEmail) ?? '';

  // set login email
  static void setLoginEmail(String value) => prefs.write(loginEmail, value);

  // get
  static String getLoginPass() => prefs.read(loginPass) ?? '';

  // set
  static void setLoginPass(String value) => prefs.write(loginPass, value);

  static void logoutFn() {
    prefs.remove(loggedInFlag);
    prefs.remove(userDetails);
  }

  static void clearAll() {
    prefs.erase();
  }
}
