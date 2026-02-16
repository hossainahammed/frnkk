import 'package:frnkk/controllers/onboarding_controller.dart';
import 'package:frnkk/controllers/profile_controller.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/SelectGenderScreen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/SelectLocationScreen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/SelectTypeScreen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/choose_genre_interest_screen.dart';
import 'package:frnkk/ui/screens/OnboardingScreen/onboarding3_view.dart';
import 'package:frnkk/ui/screens/OnboardingScreen/onboarding_screen.dart';
import 'package:frnkk/ui/screens/OnboardingScreen/onboarding_screen_2.dart';
import 'package:frnkk/ui/screens/Settings/profileScreen.dart';
import 'package:frnkk/ui/screens/artists_profile/artists_profile_controller.dart';
import 'package:frnkk/ui/screens/artists_profile/artists_profile_view.dart';
import 'package:frnkk/controllers/create_new_password_controller.dart';
import 'package:frnkk/ui/screens/create_new_password/create_new_password_view.dart';
import 'package:frnkk/controllers/forgot_password_controller.dart';
import 'package:frnkk/ui/screens/forgot_password/forgot_password_view.dart';
import 'package:frnkk/controllers/home_controller.dart';
import 'package:frnkk/ui/screens/home/home_view.dart';
import 'package:frnkk/ui/screens/login/login_controller.dart';
import 'package:frnkk/ui/screens/login/login_view.dart';
import 'package:frnkk/controllers/chat_controller.dart';
import 'package:frnkk/ui/screens/messasge/chat_view.dart';
import 'package:frnkk/ui/screens/messasge/message_settings_view.dart';
import 'package:frnkk/controllers/otp_controller.dart';
import 'package:frnkk/ui/screens/otp/otp_view.dart';
import 'package:frnkk/controllers/signup_controller.dart';
import 'package:frnkk/ui/screens/signup/signup_view.dart';
import 'package:frnkk/ui/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    // GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OnboardingController());
      }),),
    GetPage(name: AppRoutes.onboarding2, page: () => const OnboardingScreen2(),),
    GetPage(
      name: AppRoutes.onboarding3,
      page: () => const OnboardingScreen_3(),
    ),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignUpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SignUpController());
      }),
    ),
    GetPage(
      name: AppRoutes.forgot_password,
      page: () => const ForgotPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ForgotPasswordController());
      }),
    ),
    GetPage(name: AppRoutes.otp, page: () => const OtpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OtpController());
      }),),
    GetPage(
      name: AppRoutes.create_new_password,
      page: () => const CreateNewPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreateNewPasswordController());
      }),
    ),

    GetPage(
      name: AppRoutes.SelectTypeScreen,
      page: () => const SelectTypeScreen(),
    ),
    GetPage(
      name: AppRoutes.SelectGenderScreen,
      page: () => const SelectGenderScreen(),
    ),
    GetPage(
      name: AppRoutes.SelectLocationScreen,
      page: () => const SelectLocationScreen(),
    ),
    GetPage(
      name: AppRoutes.ChooseGenreInterestScreen,
      page: () => const ChooseGenreInterestScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.artists,
      page: ()=> const ArtistProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ArtistProfileController());
      }),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProfileController());
      }),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      binding: BindingsBuilder(() {
       Get.lazyPut(() => ChatController());
     }),

    ),
    GetPage(name: AppRoutes.message, page: () => const MessageSettingScreen()),
     GetPage(name: AppRoutes.artist_profile, page: () => const ArtistProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ArtistProfileController());
      }),),


  ];
}
