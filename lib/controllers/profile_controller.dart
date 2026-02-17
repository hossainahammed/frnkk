// import 'package:frnkk/ui/screens/SubscriptionScreen.dart';
// import 'package:get/get.dart';
//
// class ProfileController extends GetxController {
//   // Mock data based on design
//   var userName = "MD. AKIB AHAMED".obs;
//   var userEmail = "user@yourdomain.com".obs;
//   var planStatus = "Basic".obs;
//   var planExpiry = "dd/mm/yyyy".obs;
//
//   void onUpgradeTap() {
//     // Navigate to Subscription Screen
//     Get.to(() => const SubscriptionScreen());
//     print("Upgrade Tapped");
//   }
//
//   void onLogoutTap() {
//     print("Logout Tapped");
//   }
// }

import 'package:flutter/material.dart';
import 'package:frnkk/Model/TransactionModel.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/singer_profile_screen.dart';
import 'package:frnkk/ui/screens/Subscription/SubscriptionScreen.dart';
import 'package:frnkk/widgets/LogoutWidget.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileController extends GetxController {
  var userName = "MD. AKIB AHAMED".obs;
  var userEmail = "user@yourdomain.com".obs;
  var userDob = "dd/mm/yyyy".obs;
  var userCountry = "Select Your Country".obs;

  var planStatus = "Monthly".obs;
  var planExpiry = "N/A".obs;

  void updatePersonalInfo({
    required String name,
    required String email,
    required String dob,
    required String country,
  }) {
    userName.value = name;
    userEmail.value = email;
    userDob.value = dob;
    userCountry.value = country;

    Get.back(); // Return to Profile Screen
    Get.snackbar(
      "Success",
      "Profile updated successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void updatePlan(String newPlan) {
    planStatus.value = newPlan;
    DateTime now = DateTime.now();
    DateTime expiry = DateTime(now.year, now.month + 1, now.day);
    planExpiry.value = "${expiry.day}/${expiry.month}/${expiry.year}";
    update();
  }

  void onUpgradeTap() {
    Get.to(() => const SubscriptionScreen());
  }

  var transactions = <TransactionModel>[
    TransactionModel(
      title: "Transfer from Stripe",
      transactionId: "698094554317",
      amount: "\$ 9.00",
      status: "Confirmed",
      date: "16 Sep 2023 11:21 AM",
    ),
    TransactionModel(
      title: "Transfer from Stripe",
      transactionId: "698094554318",
      amount: "\$ 9.00",
      status: "Confirmed",
      date: "17 Sep 2023 02:30 PM",
    ),
    TransactionModel(
      title: "Transfer from Stripe",
      transactionId: "698094554319",
      amount: "\$ 9.00",
      status: "Confirmed",
      date: "18 Sep 2023 09:15 AM",
    ),
    TransactionModel(
      title: "Transfer from Stripe",
      transactionId: "698094554320",
      amount: "\$ 9.00",
      status: "Confirmed",
      date: "19 Sep 2023 12:00 PM",
    ),
  ].obs;
  void showLogoutBottomSheet() {
    Get.bottomSheet(
      const LogoutWidget(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void confirmLogout() {
    //Get.back();
    Get.offAllNamed('/login');
    //Get.to(()=>SingerProfileScreen());
  }
}
