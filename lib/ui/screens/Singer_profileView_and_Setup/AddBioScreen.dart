import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:frnkk/controllers/singer_profile_controller.dart';

class AddBioScreen extends StatelessWidget {
  const AddBioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SingerProfileController>();
    // Pre-fill the controller text if bio already exists
    final TextEditingController bioEditController =
    TextEditingController(text: controller.aboutText.value);

    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: const Color(0xFF080322),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Add Bio",
          style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Column(
            children: [
              SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  // decoration: const BoxDecoration(
                  //   gradient: RadialGradient(
                  //     center: Alignment(-0.8, -0.8),
                  //     radius: 1.5,
                  //     colors: [Color(0xFF2D1155), Color(0xFF080322)],
                  //   ),
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        "About*",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.h),
                      Expanded(
                        child: TextField(
                          controller: bioEditController,
                          maxLines: null,
                          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                          decoration: InputDecoration(
                            hintText: "Enter text",
                            hintStyle: const TextStyle(color: Colors.white24),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(color: Colors.white10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(color: Color(0xFFD458FF)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.aboutText.value = bioEditController.text;
                            Get.back();
                            Get.snackbar(
                                "Success",
                                "Bio updated successfully",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: const Color(0xFFD458FF).withOpacity(0.7),
                                colorText: Colors.white
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD458FF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
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