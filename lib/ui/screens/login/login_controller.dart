import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/SelectTypeScreen.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Add these lines
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var rememberPassword = false.obs;

  // It's best practice to close controllers when the screen is destroyed
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleRememberMe(bool? value) => rememberPassword.value = value ?? false;

  void login() {
    // Now you can access the text easily:
    print("Email: ${emailController.text}");
    print("Password: ${passwordController.text}");

  }
  

  void forgotPassword() => Get.toNamed('/forgot-password');
}