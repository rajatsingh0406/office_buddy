import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_buddy/src/core/api/app_constant.dart';
import 'package:office_buddy/src/core/shared_pref/shared_preference.dart';
import 'package:office_buddy/src/presentation/core/string/app_string.dart';
import 'package:office_buddy/src/presentation/core/widget/custom_cache_image.dart';
import 'package:office_buddy/src/presentation/home/home_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentPageIndex = 1;
  String? userImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserImage();

  }

  Future<void> loadUserImage() async {
    userImage = await PrefManager.getUserProfileUrl();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    debugPrint('user image ---$userImage');
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: const [
          Center(child: Text("data 1 ")),
          HomeScreen(),
          Center(child: Text("datadatadata 3")),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white, // Change color as needed
              width: 1.4, // Thickness of the top border
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0.0,
          currentIndex: currentPageIndex,
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'images/calendar.png',
                height: 25.sp,
                width: 25.sp,
              ),
              activeIcon: Image.asset(
                'images/calendar.png',
                height: 25.sp,
                width: 25.sp,
              ),
              label: 'Event',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/home.png', height: 25.sp, width: 25.sp),
              activeIcon: Image.asset(
                'images/home.png',
                height: 25.sp,
                width: 25.sp,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ClipOval(
                child: CustomCacheImage(
                  imageUrl: userImage?? AppString.defaultImage,
                  height: 30.h,
                  width: 30.h,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
