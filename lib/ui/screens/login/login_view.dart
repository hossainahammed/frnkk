import 'package:flutter/material.dart';
import 'package:frnkk/routes/app_routes.dart';
import 'package:frnkk/ui/screens/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:frnkk/widgets/buttons/custom_button.dart';
import 'package:frnkk/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white), // Makes the auto-button white
    ),
      body: AppBackground(
        child: SafeArea(
          // LayoutBuilder gives us the constraints of the screen
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ConstrainedBox(
                  // Forces the content to at least be the height of the screen
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // THIS IS THE KEY: Pushes everything to the bottom
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Large top space to ensure "Log in" isn't at the very top
                        const SizedBox(height: 100),

                        Text(
                          "Log in",
                          style: GoogleFonts.poltawskiNowy(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 60),

                        // Email Input
                        CustomTextField(
                          hint: "Email address",
                          controller: controller.emailController,
                        ),
                        const SizedBox(height: 15),

                        // Password Input
                        Obx(
                          () => CustomTextField(
                            hint: "Password",
                            obscureText: !controller.isPasswordVisible.value,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white70,
                                size: 20,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                        ),

                        // Remember & Forgot Password Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                    value: controller.rememberPassword.value,
                                    onChanged: controller.toggleRememberMe,
                                    side: const BorderSide(
                                      color: Colors.white54,
                                    ),
                                    activeColor: const Color(0xFFD357FE),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                ),
                                Text(
                                  "Remember Password",
                                  style: GoogleFonts.poltawskiNowy(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Log In Button
                        CustomButton(
                          label: "Log in",
                          width: 390,
                          height: 48,
                          isGlassy:
                              true, // This replaces the old GlassButton logic
                         // onPressed: controller.login,
                          onPressed: () => Get.toNamed(AppRoutes.SelectTypeScreen),
                        ),
                        //const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: controller.forgotPassword,
                              child: Text(
                                "Forget password?",
                                style: GoogleFonts.poltawskiNowy(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // Divider
                        _buildDivider("Don’t have an account?"),
                        const SizedBox(height: 32),

                        // Sign Up Button
                        CustomButton(
                          label: "Sign up",
                          width: 390,
                          height: 48,
                          onPressed: () => Get.toNamed('/signup'),
                        ),
                        const SizedBox(height: 32),

                        // Google Button
                        CustomButton(
                          label: "Google",
                          iconPath:
                              'assets/images/onboarding_images/google.svg',
                          isGlassy: true,
                          width: 390,
                          height: 48,
                          onPressed: () {
                            // Your Google Sign-In logic here
                          },
                        ),

                        // Your "little bottom padding"
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildDivider(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white24, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: GoogleFonts.poltawskiNowy(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Colors.white24, thickness: 1)),
      ],
    );
  }
}
