import 'package:flutter/cupertino.dart';
import 'package:device_preview/device_preview.dart';
import 'package:frnkk/controllers/profile_controller.dart';
import 'package:frnkk/ui/screens/artists_profile/artists_profile_controller.dart';
import 'package:frnkk/ui/screens/create_new_password/create_new_password_controller.dart';
import 'package:frnkk/ui/screens/forgot_password/forgot_password_controller.dart';
import 'package:frnkk/ui/screens/home/home_controller.dart';
import 'package:frnkk/ui/screens/login/login_controller.dart';
import 'package:frnkk/ui/screens/otp/otp_controller.dart';
import 'package:frnkk/ui/screens/signup/signup_controller.dart';
import 'package:frnkk/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'app.dart';
import 'package:frnkk/controllers/onboarding_controller.dart';


void main() {
  // Existing registrations...
  Get.lazyPut(() => OnboardingController());
  Get.put(LoginController());
  Get.lazyPut(() => SignUpController());
  Get.lazyPut(() => ForgotPasswordController());
  Get.lazyPut(() => CreateNewPasswordController());
  Get.lazyPut(() => OtpController());
  // CHANGE THIS: Use Get.put for immediate registration
  Get.put(NavigationController());  // Changed from Get.lazyPut to Get.put
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => ArtistProfileController());
  Get.lazyPut(() => ProfileController());

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const frnkApp(),
    ),
  );
}


// void main() {
//   //Get.put(OnboardingController());
//   Get.lazyPut(() => OnboardingController());
//   Get.put(LoginController());
//   Get.lazyPut(() => SignUpController());
//   Get.lazyPut(() => ForgotPasswordController());
//   Get.lazyPut(() => CreateNewPasswordController());
//   Get.lazyPut(() => OtpController());
//   Get.lazyPut(() => NavigationController());
//   Get.lazyPut(() => HomeController());
//   Get.lazyPut(() => ArtistProfileController());
//   Get.lazyPut(() => ProfileController());
//
//   runApp(
//     DevicePreview(
//       enabled: false,
//       builder: (context) => const frnkApp(),
//     ),
//   );
// }