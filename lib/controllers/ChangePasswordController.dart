import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observables for password visibility toggling
  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void onResetPassword() {
    String newPass = newPasswordController.text;
    String confirmPass = confirmPasswordController.text;

    if (newPass.isEmpty || confirmPass.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    if (newPass != confirmPass) {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    // Process logic here
    Get.back(); // Go back to Security screen
    Get.snackbar("Success", "Password changed successfully",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}