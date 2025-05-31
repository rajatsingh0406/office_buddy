import 'package:flutter/material.dart';
import 'package:office_buddy/src/core/api/api_provider.dart';
import 'package:office_buddy/src/service/authentication.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1E40AF),
        leadingWidth: 120,
        leading: Image.asset('images/app_logo.png'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Authentication(ApiProvider.getDio()).userSignOut(context);
          },
          child: Text('LogOut'),
        ),
      ),
    );
  }
}
