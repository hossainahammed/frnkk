import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/success_dialog.dart';

class CreateNewPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isConfirmVisible = false.obs;

  void togglePassword() => isPasswordVisible.toggle();
  void toggleConfirm() => isConfirmVisible.toggle();

  void updatePassword() {
  if (newPasswordController.text == confirmPasswordController.text) {
    // Show the Success Dialog
    Get.dialog(
      const SuccessDialog(),
      barrierDismissible: false, // User must click "Continue"
    );
  } else {
    Get.snackbar("Error", "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white);
  }
}

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}