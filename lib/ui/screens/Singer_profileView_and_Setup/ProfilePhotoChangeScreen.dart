import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';

class ProfilePhotoChangeScreen extends StatelessWidget {
  const ProfilePhotoChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  // decoration: const BoxDecoration(
                  //   gradient: LinearGradient(
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: [
                  //       Color(0xFF2D0A4E),
                  //       Color(0xFF080322),
                  //     ],
                  //   ),
                  // ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [

                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () => Get.back(),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Profile Photo",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 30.h),

                          // 2. Profile Photo Preview Box
                          // This uses the rounded corner look from your screenshot
                          Expanded(
                            child: Center(
                              child: Container(
                                width: double.infinity,
                                height: 400.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.r),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/SingerProfile.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // 3. Save Button at the Bottom
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                            child: SizedBox(
                              width: double.infinity,
                              height: 56.h,
                              child: ElevatedButton(
                                onPressed: () {

                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD458FF),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}