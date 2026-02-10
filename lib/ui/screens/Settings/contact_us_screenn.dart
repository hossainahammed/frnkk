import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/ContactUsController.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactUsController());

    return Scaffold(
     // backgroundColor: const Color(0xFF080322),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Contact Us",
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
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
                  height: 1.sh,
                  width: 1.sw,
                  // decoration: const BoxDecoration(
                  //   gradient: RadialGradient(
                  //     center: Alignment.centerRight,
                  //     radius: 1.5,
                  //     colors: [Color(0xFF2D0B4D), Color(0xFF080322)],
                  //   ),
                  // ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),

                        // Form Fields
                        _buildContactTextField(hint: "Name", controller: controller.nameController),
                        SizedBox(height: 16.h),

                        _buildContactTextField(hint: "Email", controller: controller.emailController),
                        SizedBox(height: 16.h),

                        _buildContactTextField(hint: "Phone", controller: controller.phoneController),
                        SizedBox(height: 16.h),

                        // Large Message Area
                        _buildContactTextField(
                          hint: "How can we help?",
                          controller: controller.messageController,
                          maxLines: 6,
                        ),

                        SizedBox(height: 40.h),

                        // Send Button
                        SizedBox(
                          width: double.infinity,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: controller.onSend,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD458FF),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                            ),
                            child: Text(
                              "Send",
                              style: GoogleFonts.poltawskiNowy(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildContactTextField({
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF25203D), // Matches the dark rounded fill from your image
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(maxLines > 1 ? 20.r : 30.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(maxLines > 1 ? 20.r : 30.r),
          borderSide: const BorderSide(color: Colors.white10),
        ),
      ),
    );
  }
}