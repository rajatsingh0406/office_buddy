import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:office_buddy/src/core/api/api_provider.dart';
import 'package:office_buddy/src/service/authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFAFAF5),
      // appBar: AppBar(
      //   backgroundColor: Color(0xff1E40AF),
      //   leadingWidth: 120,
      //   leading: Image.asset('images/app_logo.png'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100, bottom: 100),
                  child: Image.asset(
                    'images/office-buddy-high-resolution-logo-transparent.png',
                    height: 50,
                    width: 200,
                  ),
                ),
                Text('Sigin'),
                Gap(20),
                Text('Email'),
                Gap(10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'email'
                    ),
                ),
                Gap(20),
                Text('Password'),
                Gap(10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password'
                    ),
                ),
            
                Gap(40.h),
                GestureDetector(
                  onTap: (){
                     Authentication(ApiProvider.getDio()).loginWithEmail(
                        context,
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Color(0XFF1E40AF)),
                      child: Center(child: Text('Login',style: TextStyle(color: Colors.white),)),
                  ),
                ),
                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Authentication(ApiProvider.getDio()).loginWithEmail(
                //         context,
                //         emailController.text.trim(),
                //         passwordController.text.trim(),
                //       );
                //     },
                //     child: Text('Login'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
