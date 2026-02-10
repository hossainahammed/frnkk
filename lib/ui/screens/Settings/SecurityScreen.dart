import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/ui/screens/Settings/ChangePasswordScreen.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isRemembered = true.obs;

    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: const Color(0xFF080322),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text("Security",
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),),
      ),
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Column(
            children: [
              SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top),
              Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Remember Me", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                        Obx(() => CupertinoSwitch(
                          activeColor: const Color(0xFFFF5E5E),
                          value: isRemembered.value,
                          onChanged: (val) => isRemembered.value = val,
                        )),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Text("Change you Password", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD458FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                        ),
                        onPressed: () => Get.to(() => const ChangePasswordScreen()),
                        child: Text("Change Password",
                          style: GoogleFonts.poltawskiNowy(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}