import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/routes/app_routes.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessSubscriptionDialog extends StatelessWidget {
  final bool fromMainSwipe;
  const SuccessSubscriptionDialog({super.key, this.fromMainSwipe = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF130B2B),
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100.h,
              width: 100.h,
              decoration: const BoxDecoration(
                color: Color(0xFFFF5E5E),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/Congratulations.png',
                //color: const Color(0xFF080322),
                width: 50.sp,
                height: 50.sp,
              ),
              // child: ImageIcon(
              //   AssetImage('assets/images/Congratulations.png'),
              //   color: const Color(0xFF080322),
              //   size: 50.sp,
              // ),
            ),
            SizedBox(height: 24.h),
            Text(
              "Congratulations!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "You have successfully subscribed. Enjoy the benefits!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14.sp),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD458FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                //onPressed: () => Get.back(),

                /// ////////////////////////////////////////////////// For testing here i just call profile screen  ////////////////////////////////////////////
                // onPressed: () =>Get.to(() => ProfileScreen()),
                onPressed: () {
                  if (fromMainSwipe) {
                    // If came from Swipe Page, go back to Home (MainSwipe)
                    Get.offAllNamed(AppRoutes.home);
                  } else {
                    // Otherwise, go to Profile Screen
                    Get.toNamed(AppRoutes.profile);
                  }
                  // Get.offAllNamed(AppRoutes.profile);
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.poltawskiNowy(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}