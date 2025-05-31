import 'package:shared_preferences/shared_preferences.dart';

import '../api/app_constant.dart';

class PrefManager {
  // setting user's logged-in status
  static void setLoggedInStatusTrue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConstant.spIsLoggedIn, true);
  }

  static void setUserAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spUserAccessToken, accessToken);
  }

  static void setUserSessionId(String sessionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spUserSessionId, sessionId);
  }

  static void setUserCsrfToken(String csrfToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spUserCsrfToken, csrfToken);
  }

  static void setUserDevalayId(String devalayId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spUserDevalayId, devalayId);
  }

  static void setAdmin(String admin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.admin, admin);
  }

  static void setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spUserName, userName);
  }

  static void setUserEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spUserEmail, userEmail);
  }

  static void setUserProfileImage(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spUserImageUrl, imageUrl);
  }

  static void setUserProfileImageUrl(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spUserProfileUrl, imageUrl);
  }

  /// Checking whether user is logged in or not
  static Future<bool> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool(AppConstant.spIsLoggedIn);
    return value ?? false;
  }

  static Future<String?> getUserSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppConstant.spUserSessionId);
  }

  static Future<String?> getUserAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppConstant.spUserAccessToken);
  }

  static void setLoginMethod(String loginMethod) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spUserLoginMethod, loginMethod);
  }

  static Future<String?> getUserCsrfToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppConstant.spUserCsrfToken);
  }

  static Future<String?> getUserLoginMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppConstant.spUserLoginMethod);
  }

  static Future<String?> getUserDevalayId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppConstant.spUserDevalayId);
  }

  static Future<String?> getAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppConstant.admin);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppConstant.spUserEmail);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppConstant.spUserName);
  }

  static Future<String?> getUserProfileImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppConstant.spUserProfileUrl);
  }

  //clearing the preferences
  static void clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
