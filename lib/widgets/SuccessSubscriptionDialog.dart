import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuccessSubscriptionDialog_DEMO extends StatelessWidget {
  const SuccessSubscriptionDialog_DEMO({super.key});

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
              height: 120.h,
              width: 120.h,
              decoration: const BoxDecoration(
                color: Color(0xFFFF5E5E),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.emoji_events, color: const Color(0xFF080322), size: 60.sp),
            ),
            SizedBox(height: 24.h),
            Text(
              "Congratulations!",
              style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            Text(
              "You have successfully subscribed 1 month premium. Enjoy the benefits!",
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
                ),
                onPressed: () => Get.offAllNamed('/home'), // Or your main app screen
                child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}