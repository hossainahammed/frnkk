import 'package:flutter/material.dart';
import 'package:frnkk/controllers/signup_controller.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:frnkk/widgets/buttons/custom_button.dart';
import 'package:frnkk/widgets/custom_text_field.dart';
import 'package:frnkk/widgets/custom_drop_down.dart'; // Create this based on my previous message
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Makes the auto-button white
      ),
      body: AppBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),

                          CustomTextField(
                            hint: "Username",
                            controller: controller.usernameController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Username is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),

                          CustomTextField(
                            hint: "Email address",
                            controller: controller.emailController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Email is required";
                              }
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (!emailRegex.hasMatch(val)) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),

                          // Dropdown for Role
                          Obx(
                            () => CustomDropdown(
                              hint: "Select Role",
                              value: controller.selectedRole.value.isEmpty
                                  ? null
                                  : controller.selectedRole.value,
                              items: const [
                                "Musician",
                                "Songwriter",
                                "Producer",
                                "Singer",
                              ],
                              onChanged: (val) =>
                                  controller.selectedRole.value = val ?? "",
                            ),
                          ),
                          const SizedBox(height: 15),

                          Obx(
                            () => CustomTextField(
                              hint: "Password",
                              controller: controller.passwordController,
                              obscureText: !controller.isPasswordVisible.value,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Password is required";
                                }
                                if (val.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white38,
                                  size: 20,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          Obx(
                            () => CustomTextField(
                              hint: "Confirm password",
                              controller: controller.confirmPasswordController,
                              obscureText:
                                  !controller.isConfirmPasswordVisible.value,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Confirm password is required";
                                }
                                if (val != controller.passwordController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isConfirmPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white38,
                                  size: 20,
                                ),
                                onPressed:
                                    controller.toggleConfirmPasswordVisibility,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Main Sign Up Button
                          CustomButton(
                            label: "Sign up",
                            width: 390,
                            height: 48,
                            onPressed: () {
                              controller.signUp();
                            },
                          ),
                          const SizedBox(height: 25),

                          _buildDivider("Already have an account?"),
                          const SizedBox(height: 25),

                          // Log in Button (Glassy)
                          CustomButton(
                            label: "Log in",
                            isGlassy: true,
                            width: 390,
                            height: 48,
                            onPressed: () => Get.back(), // Goes back to Login
                          ),
                          const SizedBox(height: 15),

                          // Google Button
                          CustomButton(
                            label: "Google",
                            isGlassy: true,
                            width: 390,
                            height: 48,
                            iconPath:
                                'assets/images/onboarding_images/google.svg',
                            onPressed: () {},
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
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

  Widget _buildDivider(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white24)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: GoogleFonts.poltawskiNowy(color: Colors.white, fontSize: 14),
          ),
        ),
        const Expanded(child: Divider(color: Colors.white24)),
      ],
    );
  }
}
