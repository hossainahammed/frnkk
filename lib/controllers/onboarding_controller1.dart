import 'package:get/get.dart';



class OnboardingController extends GetxController {
  void login() {
    Get.toNamed('/login'); 
  }
  void signup() 
  {
    Get.toNamed('/signup');
  }
  void continueAsGuest() => print("Continuing as Guest");
  void loginWithGoogle() => print("Google Sign-in triggered");
}