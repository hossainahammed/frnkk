// success_dialog.dart or bottom of create_new_password_view.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frnkk/widgets/buttons/custom_button.dart';
import 'package:get/get.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(
        255,
        48,
        43,
        69,
      ), // Dark Navy matching the image
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Dialog hugs content
          children: [
            // The Success Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/authentication_images/success.png', // Ensure this path matches your pubspec.yaml
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 25),

            Text(
              "Success",
              style: GoogleFonts.poltawskiNowy(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              "Your password is successfully\ncreated",
              textAlign: TextAlign.center,
              style: GoogleFonts.poltawskiNowy(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),

            // Continue Button inside Pop-up
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: "Continue",
                onPressed: () {
                  Get.offAllNamed('/login'); // Clears history and goes to Login
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
