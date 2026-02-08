import 'package:flutter/material.dart';
import 'package:frnkk/controllers/onboarding_controller.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/buttons/custom_button.dart';
import 'package:frnkk/widgets/buttons/glass_button.dart';

class OnboardingScreen_3 extends GetView<OnboardingController> {
  const OnboardingScreen_3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding_images/Onboarding3.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Dark Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),

          // 3. UI Components
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Log In Button - Using the Glassy property
                  GlassButton(label: "Log in", onPressed: controller.login),
                  const SizedBox(height: 15),

                  // Sign Up Button - Using the primary purple color
                  CustomButton(
                    label: "Sign up",
                    color: const Color.fromARGB(255, 210, 82, 222),
                    width: double.infinity,
                    height: 48,
                    onPressed: controller.signup,
                  ),
                  const SizedBox(height: 25),

                  // Guest Text
                  GestureDetector(
                    onTap: controller.continueAsGuest,
                    child: const Text(
                      "Continue as Guest",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Divider
                  const Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white54)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white54)),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Google Button - Using iconPath and Glassy effect
                  CustomButton(
                    label: "Google",
                    iconPath: 'assets/images/onboarding_images/google.svg',
                    isGlassy: true,
                    width: double.infinity,
                    height: 48,
                    onPressed: controller.loginWithGoogle,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}