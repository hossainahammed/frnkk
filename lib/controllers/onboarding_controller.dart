import 'package:frnkk/ui/screens/OnboardingScreen/onboarding_screen_2.dart';
import 'package:get/get.dart';


class OnboardingController extends GetxController {
  // Step control
  var currentStep = 0.obs;

  // Selections
  var selectedType = ''.obs;
  var selectedGender = ''.obs;
  var selectedLocation = ''.obs;

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void selectType(String type) {
    selectedType.value = type;
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  void selectLocation(String location) {
    selectedLocation.value = location;
  }
}
