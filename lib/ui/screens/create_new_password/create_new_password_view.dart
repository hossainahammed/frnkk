import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/create_new_password/create_new_password_controller.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:frnkk/widgets/buttons/custom_button.dart';
import 'package:frnkk/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewPasswordScreen extends GetView<CreateNewPasswordController> {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create\nNew Password",
                textAlign: TextAlign.center,
                style: GoogleFonts.poltawskiNowy(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Enter your new password",
                style: GoogleFonts.poltawskiNowy(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 40),

              // New Password Field
              Obx(() => CustomTextField(
                hint: "Enter new password",
                controller: controller.newPasswordController,
                obscureText: !controller.isPasswordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white38,
                  ),
                  onPressed: controller.togglePassword,
                ),
              )),
              const SizedBox(height: 15),

              // Confirm Password Field
              Obx(() => CustomTextField(
                hint: "Confirm your password",
                controller: controller.confirmPasswordController,
                obscureText: !controller.isConfirmVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isConfirmVisible.value ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white38,
                  ),
                  onPressed: controller.toggleConfirm,
                ),
              )),
              const SizedBox(height: 40),

              CustomButton(
                label: "Continue",
                onPressed: controller.updatePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}