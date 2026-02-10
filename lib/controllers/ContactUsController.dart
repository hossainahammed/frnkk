import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  void onSend() {

    if (nameController.text.isEmpty || messageController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in your name and message",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }


    Get.snackbar(
      "Success",
      "Your message has been sent!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

   
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    messageController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }
}