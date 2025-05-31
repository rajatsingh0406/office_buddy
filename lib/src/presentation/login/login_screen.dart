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
      appBar: AppBar(
        backgroundColor: Color(0xff1E40AF),
        leadingWidth: 120,
        leading: Image.asset('images/app_logo.png'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('welcome to Office Buddy login screen'),
            Gap(20),
            Text('Email'),
            Gap(10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Gap(20),
            Text('Password'),
            Gap(10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            Gap(40.h),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Authentication(ApiProvider.getDio()).loginWithEmail(
                    context,
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
