import 'package:frnkk/ui/screens/InitialSetupFlow/SelectGenderScreen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/SelectLocationScreen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/SelectTypeScreen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/choose_genre_interest_screen.dart';
import 'package:frnkk/ui/screens/OnboardingScreen/onboarding3_view.dart';
import 'package:frnkk/ui/screens/OnboardingScreen/onboarding_screen.dart';
import 'package:frnkk/ui/screens/OnboardingScreen/onboarding_screen_2.dart';
import 'package:frnkk/ui/screens/create_new_password/create_new_password_view.dart';
import 'package:frnkk/ui/screens/forgot_password/forgot_password_view.dart';
import 'package:frnkk/ui/screens/home/home_view.dart';
import 'package:frnkk/ui/screens/login/login_view.dart';
import 'package:frnkk/ui/screens/otp/otp_view.dart';
import 'package:frnkk/ui/screens/signup/signup_view.dart';
import 'package:frnkk/ui/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';


class AppPages {
  static final pages = [
   // GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.onboarding2, page: () => const OnboardingScreen2()),
    GetPage(name: AppRoutes.onboarding3, page: () => const OnboardingScreen_3()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignUpScreen(),),
    GetPage(name: AppRoutes.forgot_password, page: () => const ForgotPasswordScreen()),
    GetPage(name: AppRoutes.otp, page: () => const OtpScreen()),
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.create_new_password, page: () => const CreateNewPasswordScreen()),

    GetPage(name: AppRoutes.SelectTypeScreen, page: () => const SelectTypeScreen()),
    GetPage(name: AppRoutes.SelectGenderScreen, page: () => const SelectGenderScreen()),
    GetPage(name: AppRoutes.SelectLocationScreen, page: () => const SelectLocationScreen()),
    GetPage(name: AppRoutes.ChooseGenreInterestScreen, page: () => const ChooseGenreInterestScreen()),


  ];
}
