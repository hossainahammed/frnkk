import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/ChangePasswordController.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

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
        title: Text(
          "Change Password",
            style: GoogleFonts.nunitoSans(
              color: Colors.white,
              fontSize: 24.sp,
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
                        SizedBox(height: 40.h),
                        Text(
                          "Create new password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Your new password must be unique from those previously used.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 40.h),

                        // New Password Field
                        _buildPasswordField(
                          hint: "New Password",
                          controller: controller.newPasswordController,
                          obscureText: controller.isNewPasswordVisible,
                        ),

                        SizedBox(height: 20.h),

                        // Confirm Password Field
                        _buildPasswordField(
                          hint: "Confirm Password",
                          controller: controller.confirmPasswordController,
                          obscureText: controller.isConfirmPasswordVisible,
                        ),

                        SizedBox(height: 40.h),

                        // Reset Password Button
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: controller.onResetPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD458FF),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                            ),
                            child: Text(
                              "Reset Password",
                              style: GoogleFonts.poltawskiNowy(
                                color: Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
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

  Widget _buildPasswordField({
    required String hint,
    required TextEditingController controller,
    required RxBool obscureText,
  }) {
    return Obx(() => TextField(
      controller: controller,
      obscureText: !obscureText.value,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF25203D), // Matches the dark input fill
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText.value ? Icons.visibility : Icons.visibility_off,
            color: Colors.white38,
          ),
          onPressed: () => obscureText.toggle(),
        ),
      ),
    ));
  }
}