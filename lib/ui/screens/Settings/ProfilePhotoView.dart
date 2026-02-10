import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePhotoView extends StatelessWidget {
  const ProfilePhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: const Color(0xFF080322),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Profile Photo",
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontSize: 24.sp,
          ),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //const Spacer(),
              SizedBox(height: 20.h),
              Center(
                child: CircleAvatar(
                  radius: 150.r,
                  backgroundImage: const AssetImage('assets/images/Rectangle.png'),
                ),
              ),
             // const Spacer(),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD458FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                    ),
                    child: const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ],
      ),
    );
  }
}