import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/forgot_password/forgot_password_controller.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:frnkk/widgets/buttons/custom_button.dart';
import 'package:frnkk/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // The back arrow to return to Login
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
            mainAxisAlignment: MainAxisAlignment.center, // Centered content
            children: [
              Text(
                "Forget Password",
                style: GoogleFonts.poltawskiNowy(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Don't worry! It occurs. Please enter the email address linked with your account.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poltawskiNowy(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              
              CustomTextField(
                hint: "Email address",
                controller: controller.emailController,
              ),
              const SizedBox(height: 30),
              
              CustomButton(
                label: "Send OTP",
                onPressed: controller.sendOTP,
              ),
            ],
          ),
        ),
      ),
    );
  }
}