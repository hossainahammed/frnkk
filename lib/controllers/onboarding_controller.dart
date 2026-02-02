import 'package:frnkk/ui/screens/onboarding_screen_2.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  void nextStep() {
    print("Navigating to next screen...");
    Get.to(() => OnboardingScreen2());
  }
}