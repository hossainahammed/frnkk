import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/profile_controller.dart';
import 'package:get/get.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0D082B),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        border: Border(
          top: BorderSide(color: Colors.white54, width: 2.w),
          // left: BorderSide(color: Colors.white10, width: 1.w),
          // right: BorderSide(color: Colors.white10, width: 1.w),
          bottom: BorderSide.none,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Warning Icon
          Container(
            height: 70.h,
            width: 70.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                height: 55.h,
                width: 55.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5E5E),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.warning_amber_rounded, color: Colors.white, size: 30.sp),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          Text(
            "Logout",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            "Are you sure you want to log out? You will need to sign in again to access your account.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),

          SizedBox(height: 32.h),

          Row(
            children: [

              Expanded(
                child: SizedBox(
                  height: 56.h,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.find<ProfileController>().confirmLogout();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFF5E5E)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(color: const Color(0xFFFF5E5E), fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 16.w),


              Expanded(
                child: SizedBox(
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25203D),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}