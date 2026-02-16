import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();

  void verifyOtp() {
    print("Verifying OTP: ${otpController.text}");
    Get.toNamed('/create-new-password');
    // Logic to verify and move to 'Reset Password' or 'Home'
  }

  void resendCode() {
    print("Resending OTP...");
  }
  

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}