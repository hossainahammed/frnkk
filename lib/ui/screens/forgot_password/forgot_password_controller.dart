import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  void sendOTP() {
    // 1. Add your logic to call the API/Firebase here
    print("Sending OTP to: ${emailController.text}");

    // 2. Navigate to the OTP screen
    Get.toNamed('/verify-otp'); 
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}