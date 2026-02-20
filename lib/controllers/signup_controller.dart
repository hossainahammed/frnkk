import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var selectedRole = "".obs;

  // Add these for visibility control
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  // Toggle methods
  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  void signUp() {
    if (formKey.currentState!.validate()) {
      if (selectedRole.value.isEmpty) {
        Get.snackbar(
          "Error",
          "Please select a role",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.8),
          colorText: Colors.white,
        );
        return;
      }
      Get.snackbar(
        "Success",
        "Account created successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Get.offNamed('/login');
      });
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
