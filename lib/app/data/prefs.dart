import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class Preference {
  static final prefs = GetStorage();
  static const onboardFlag = 'obFlag';
  static const loggedInFlag = 'loginFlag';

  static const userDetails = 'userDetails';
  static const userDP = 'userDP';
  static const rememberMeFlag = 'rememberMeFlag';
  static const loginEmail = 'loginEmail';
  static const loginPass = 'loginPass';

  static bool getOnboardFlag() => prefs.read(onboardFlag) ?? false;
  static void setOnboardFlag(bool value) => prefs.write(onboardFlag, value);

  static bool getLoggedInFlag() => prefs.read(loggedInFlag) ?? false;
  static void setLoggedInFlag(bool value) => prefs.write(loggedInFlag, value);

  // get
  static UserModel getUserDetails() {
    var result = prefs.read(userDetails);
    return UserModel.fromJson(json.decode(result));
  }

  // set
  static void setUserDetails(UserModel value) {
    prefs.write(userDetails, json.encode(value.toJson()));
  }

  // get dp
  static String getUserDP() => prefs.read(userDP) ?? '';

  // set dp
  static void setUserDP(String value) => prefs.write(userDP, value);

  static bool getRememberMeFlag() => prefs.read(rememberMeFlag) ?? false;

  static void setRememberMeFlag(bool value) {
    prefs.write(rememberMeFlag, value);
  }

  static String getLoginEmail() => prefs.read(loginEmail) ?? '';

  static void setLoginEmail(String value) => prefs.write(loginEmail, value);

  static String getLoginPass() => prefs.read(loginPass) ?? '';

  static void setLoginPass(String value) => prefs.write(loginPass, value);

  static void logoutFn() {
    prefs.remove(loggedInFlag);
    prefs.remove(userDetails);
  }

  static void clearAll() {
    prefs.erase();
  }
}
