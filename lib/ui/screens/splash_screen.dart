import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const OnboardingScreen(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 300),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/Onboarding_1.svg',
            height: 124,
            width: 124,
          ),
          const SizedBox(height: 24),
          const Text(
            'Splash',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Splash text.',
              textAlign: TextAlign.center,
              maxLines: 4,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 100),
          //Spacer(),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
