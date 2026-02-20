import 'package:flutter/material.dart';
import 'package:frnkk/routes/app_routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var rememberPassword = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleRememberMe(bool? value) => rememberPassword.value = value ?? false;

  void login() {
    if (formKey.currentState!.validate()) {
      // Access the text if valid
      print("Email: ${emailController.text}");
      print("Password: ${passwordController.text}");

      // Perform navigation or API call here
      Get.toNamed(AppRoutes.SelectTypeScreen);
    }
  }

  void forgotPassword() => Get.toNamed('/forgot-password');
}
