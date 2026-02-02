import 'package:frnkk/ui/screens/onboarding_screen.dart';
import 'package:frnkk/ui/screens/onboarding_screen_2.dart';
import 'package:frnkk/ui/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';


class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen2()),

  ];
}
