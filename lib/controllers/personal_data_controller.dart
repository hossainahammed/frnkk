import 'package:flutter/material.dart';
import 'package:frnkk/controllers/profile_controller.dart';
import 'package:get/get.dart';


class PersonalDataController extends GetxController {
  /// Text Editing Controllers
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController dobController;
  final profileController = Get.find<ProfileController>();
  /// Observable for country selection
   var selectedCountry = "".obs;
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   // Initialize with existing data from design
  //   nameController = TextEditingController(text: "MD. AKIB AHAMED");
  //   emailController = TextEditingController(text: "user@yourdomain.com");
  //   dobController = TextEditingController(text: "dd/mm/yyyy");
  // }



  @override
  void onInit() {
    super.onInit();
    // Sync with ProfileController data
    nameController = TextEditingController(text: profileController.userName.value);
    emailController = TextEditingController(text: profileController.userEmail.value);
    dobController = TextEditingController(text: "dd/mm/yyyy");
  }

  void onSave() {
    // Logic to save data
    Get.snackbar(
      "Success",
      "Profile updated successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.7),
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.onClose();
  }
}