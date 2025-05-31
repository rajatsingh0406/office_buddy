import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:office_buddy/src/core/api/api_provider.dart';
import 'package:office_buddy/src/core/api/app_constant.dart';
import 'package:office_buddy/src/core/utils/shared_preference.dart';
import 'package:office_buddy/src/data/model/login/login_model.dart'
    as pmg_model;
import 'package:office_buddy/src/presentation/landing/landing_screen.dart';
import 'package:office_buddy/src/presentation/login/login_screen.dart';

class Authentication {
  final Dio _dio;

  Authentication(this._dio);

  Future<void> loginWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final fcmToken = await PrefManager.getUserFCMToken();
      final Map<String, dynamic> data = {
        "username": email,
        "password": password,
        "device_token": fcmToken,
      };
      final response = await _dio.post(
        AppConstant.signIn,
        data: jsonEncode(data),
      );

      await sendAccessTokenToServer(context, data, AppConstant.signIn);

      PrefManager.setLoginMethod('email');
    } catch (e) {
      debugPrint("Error during email login: ${e.toString()}");
      // Fluttertoast.showToast(msg: "Error during email login");
    }
  }

  Future<void> sendAccessTokenToServer(
    BuildContext context,
    Map<String, dynamic> data,
    String? apiUrl,
  ) async {
    final fcmToken = await PrefManager.getUserFCMToken();
    debugPrint("this is the fcm token--->>>$fcmToken");
    debugPrint("this is the access token--->>>$data");

    try {
      final response = await _dio.post("$apiUrl", data: jsonEncode(data));
      debugPrint("this is the response data--->>>${response.data}");

      final loginData = pmg_model.LoginResponseModel.fromJson(response.data);
      debugPrint("this is the response data--->>>$loginData");
      final pmgId = loginData.user?.id ?? '';
      final pmgUserFullname = loginData.user?.name ?? '';
      final pmgUserProfileUrl = loginData.user?.dp ?? '';
      final pmgUserEmail = loginData.user?.email ?? '';
      final accessToken = loginData.tokens?.access ?? '';
      final refreshToken = loginData.tokens?.refresh ?? '';
      debugPrint("this is the pmg user email--->>>$pmgUserEmail");
      debugPrint("this is the pmg user fullname--->>>$pmgUserFullname");
      debugPrint("this is the pmg user profile url--->>>$pmgUserProfileUrl");
      debugPrint("this is the pmg user access token--->>>$accessToken");
      debugPrint("this is the pmg user refresh token--->>>$refreshToken");
      PrefManager.setUserPmgId(pmgId.toString());
      PrefManager.setUserName(pmgUserFullname);
      PrefManager.setUserEmail(pmgUserEmail);
      PrefManager.setUserAccessToken(accessToken);
      ApiProvider.setAccessToken(accessToken);
      PrefManager.setUserRefreshToken(refreshToken);
      PrefManager.setUserProfileImageUrl(pmgUserProfileUrl);

      if (response.statusCode == 200) {
        debugPrint("Access token sent successfully!");
        PrefManager.setLoggedInStatusTrue();
        // navigating to landing screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
        // AppRouter.navigateTo(
        //   AppRoutes.landingRoute.route,
        //   clearStack: true,
        //   transitionDuration: const Duration(milliseconds: 600),
        //   transition: TransitionType.inFromLeft,
        // );
      } else {
        debugPrint("Error while sending access token: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint("Error sending access token: ${e.toString()}");
      debugPrint("Stack trace: $stackTrace");
    }
  }

  void navigate(context) async {
    final isLoggedIn = await PrefManager.getLoggedInStatus();
    if (isLoggedIn) {
      await checkSessionValidity(context);
    } else {
      debugPrint("the seseion is not validate");
      Future.delayed(const Duration(seconds: 3), () {
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    }
  }


   Future<bool> checkSessionValidity(context) async {
    try {
      final accessToken = await PrefManager.getUserAccessToken();
      final refreshToken = await PrefManager.getUserRefreshToken();

      debugPrint('Access Token: $accessToken');
      debugPrint('Refresh Token: $refreshToken');

      // If access token is available, verify it
      if (accessToken != null && accessToken.isNotEmpty) {
        final response = await _dio.post(
          AppConstant.verifyToken,
          data: jsonEncode({"token": accessToken}),
        );

        if (response.statusCode == 200) {
          ApiProvider.setAccessToken(accessToken);
          _navigateToLanding(context);
          return true;
        } else if (response.statusCode == 400) {
          // Try refreshing the token
          final refreshResponse = await _dio.post(
            AppConstant.refreshToken,
            data: jsonEncode({'refresh': refreshToken}),
          );

          if (refreshResponse.statusCode == 200) {
            final newAccessToken = response.data['access'];
            final newRefreshToken = response.data['refresh'];

            debugPrint('new access token ---$newAccessToken');
            debugPrint('new refresh token ---$newRefreshToken');

            PrefManager.setUserAccessToken(newAccessToken);
            PrefManager.setUserRefreshToken(newRefreshToken);

            ApiProvider.setAccessToken(newAccessToken);
            _navigateToLanding(context);
            return true;
          } else {
            await _handleLogout(context);
            return false;
          }
        }
      }

      // If access token is null or empty
      await _handleLogout(context);
      return false;
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 403) {
        await _handleLogout(context);
      } else {
        debugPrint('Unknown error during session check: $e');
      }
      return false;
    }
  }

   Future<void> userSignOut(context) async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    final sessionId = await PrefManager.getUserSessionId();
    final csrf = await PrefManager.getUserCsrfToken();

    // if (await googleSignIn.isSignedIn()) {
    //   try {
    //     await googleSignIn.disconnect();
    //   } catch (disconnectError) {
    //     Logger.logError('Google disconnect failed: $disconnectError');
    //     // Proceed even if disconnect fails, as signOut will suffice
    //   }
    //   await googleSignIn.signOut();
    // }
    // await FirebaseAuth.instance.signOut();
    // await googleSignIn.signOut();
    final response = await ApiProvider.getDio().post(
      AppConstant.signOut,
      // options: Options(headers: {
      //   'Cookie': 'sessionid=$sessionId;csrftoken=$csrf',
      //   'X-CSRFToken': csrf,
      //   'Referer': AppConstant.signOut,
      //   'Content-Type': AppConstant.signOut
      // }),
    );
    if (response.statusCode == 200) {
      PrefManager.clearPreferences();

     Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()));
      Fluttertoast.showToast(msg: 'User Logged out successfully');
    } else {
      Fluttertoast.showToast(msg: 'User Logged out failed');
    }
  }

  void _navigateToLanding(context) {
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()));
   
  }

  Future<void> _handleLogout(context) async {
    userSignOut(context);
    // await FirebaseAuth.instance.signOut();
    // PrefManager.clearPreferences();
    // AppRouter.navigateTo(
    //   AppRoutes.loginRoute.route,
    //   clearStack: true,
    //   transition: TransitionType.inFromLeft,
    //   transitionDuration: const Duration(milliseconds: 600),
    // );

    // Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
