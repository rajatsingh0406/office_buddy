
import 'package:office_buddy/src/presentation/core/string/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  // setting user's logged-in status
  static void setLoggedInStatusTrue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppString.spIsLoggedIn, true);
  }

  static void setUserAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spUserAccessToken, accessToken);
  }

  static void setUserRefreshToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spUserRefreshToken, accessToken);
  }

  static void setUserFCMToken(String fcmToken) async {
    print("this is the fcm token--->>>$fcmToken");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spUserFCMToken, fcmToken);
  }

  static void setUserSessionId(String sessionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spUserSessionId, sessionId);
  }

  static void setUserCsrfToken(String csrfToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spUserCsrfToken, csrfToken);
  }

  static void setUserPmgId(String pmgId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spPmgId, pmgId);
  }

  static void setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spUserName, userName);
  }

  static void setUserEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spUserEmail, userEmail);
  }

  static void setUserProfileImage(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spUserImageUrl, imageUrl);
  }

  static void setUserProfileImageUrl(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spUserProfileUrl, imageUrl);
  }

  static Future<void> setUserWorkSpaceUrl(String workSpaceUrl) async {
    print("this is the url--$workSpaceUrl");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppString.spUserWorkSpaceUrl, workSpaceUrl);
  }

  static void setLoginMethod(String loginMethod) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.spUserLoginMethod, loginMethod);
  }

  /// Checking whether user is logged in or not
  static Future<bool> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool(AppString.spIsLoggedIn);
    return value ?? false;
  }

  static Future<String?> getUserRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(
        "this is the refresh token--->>>${prefs.getString(AppString.spUserRefreshToken)}");
    return prefs.getString(AppString.spUserRefreshToken);
  }
  
  static Future<String?> getUserFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(
        "this is the fcm token--->>>${prefs.getString(AppString.spUserFCMToken)}");
    return prefs.getString(AppString.spUserFCMToken);
  }

  static Future<String?> getUserSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppString.spUserSessionId);
  }

  static Future<String?> getUserAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppString.spUserAccessToken);
  }

  static Future<String?> getUserCsrfToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppString.spUserCsrfToken);
  }

  static Future<String?> getUserImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppString.spUserImageUrl);
  }

  static Future<String?> getUserProfileUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppString.spUserProfileUrl);
  }

  static Future<String?> getUserPmgId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppString.spPmgId);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppString.spUserName);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppString.spUserEmail);
  }

  static Future<String?> getUserWorkSpaceUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppString.spUserWorkSpaceUrl);
  }

  static Future<String?> getUserLoginMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(AppString.spUserLoginMethod);
  }

  //clearing the preferences
  static void clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
