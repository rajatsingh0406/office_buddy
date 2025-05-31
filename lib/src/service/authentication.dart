import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:office_buddy/src/core/api/api_provider.dart';
import 'package:office_buddy/src/core/api/app_constant.dart';
import 'package:office_buddy/src/core/utils/shared_preference.dart';
import 'package:office_buddy/src/data/model/login/login_model.dart'
    as pmg_model;
import 'package:office_buddy/src/presentation/landing/landing_screen.dart';

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
      final pmgUserProfileUrl = loginData.user?.profilePic ?? '';
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
}
