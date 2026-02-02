import 'package:flutter/material.dart';
import 'package:frnkk/controllers/onboarding_controller.dart';
import 'package:get/get.dart';



class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Onboarding_2.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Step',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Into Your Music world',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [

                      Expanded(
                        child: GestureDetector(
                          onTap: () =>Get.to(() => OnboardingScreen2()),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD652E1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 30),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Circular Icon Button
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD652E1).withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.keyboard_double_arrow_right,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}