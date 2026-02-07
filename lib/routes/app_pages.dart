import 'package:frnkk/ui/screens/InitialSetupFlow/SelectGenderScreen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/SelectLocationScreen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/SelectTypeScreen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/choose_genre_interest_screen.dart';
import 'package:frnkk/ui/screens/OnboardingScreen/onboarding_screen.dart';
import 'package:frnkk/ui/screens/OnboardingScreen/onboarding_screen_2.dart';
import 'package:frnkk/ui/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';


class AppPages {
  static final pages = [
   // GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen2()),
    GetPage(name: AppRoutes.SelectTypeScreen, page: () => const SelectTypeScreen()),
    GetPage(name: AppRoutes.SelectGenderScreen, page: () => const SelectGenderScreen()),
    GetPage(name: AppRoutes.SelectLocationScreen, page: () => const SelectLocationScreen()),
    GetPage(name: AppRoutes.ChooseGenreInterestScreen, page: () => const ChooseGenreInterestScreen()),


  ];
}
