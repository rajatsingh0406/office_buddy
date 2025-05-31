class AppConstant {
  // static const baseUrl = 'https://pmg.engineering/apis'; // for production
  static const baseUrl = 'http://192.168.1.42:8001/apis'; // SIT // for local
  static const localUrl =
      "http://192.168.1.46:8000/apis"; // pmg.engineering == 192.168.1.222:8001 and https == http
//   static const dynamicLocalUrl = "http://192.168.1.222:8001";
  // static const dynamicBaseUrl = "https://pmg.engineering"; // for production
  static const dynamicBaseUrl = "http://192.168.1.42:8001";
  static const apiTimeOutInSecond = 100; // SIT
  static const appVersion = '$baseUrl/appversion/';

  // login
  static const googleLogin = '$baseUrl/google-login/';
  static const appleLogin = '$baseUrl/apple-login/';
  static const signIn = '$dynamicBaseUrl/apis/signin/';
  static const signUp = '$dynamicBaseUrl/apis/signup/';
  static const signOut = '$dynamicBaseUrl/apis/signout/';
  static const forgotPassword = '$dynamicBaseUrl/apis/forgot-password/';
  static const validateOtp = '$dynamicBaseUrl/apis/validate-otp/';
  static const resetPassword = '$dynamicBaseUrl/apis/reset-password/';
  static const verifyToken = '$baseUrl/token/verify/';
  static const refreshToken = '$baseUrl/token/refresh/';

  static const feedPost = '$dynamicBaseUrl/Post/';
}
