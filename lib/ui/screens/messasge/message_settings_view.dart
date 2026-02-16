import 'package:flutter/material.dart';
import 'package:frnkk/controllers/chat_controller.dart';
import 'package:frnkk/ui/screens/messasge/media_gallery_view.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:google_fonts/google_fonts.dart'; // Optional: for the exact font look
import 'dart:ui'; // Add this line
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageSettingScreen extends StatelessWidget {
  const MessageSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the data passed from the chat screen
    final Map userData = Get.arguments;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Back Button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
              ),
              const SizedBox(height: 20),

              // 2. Profile Image with circular border
              CircleAvatar(
                radius: 65, // Slightly larger to match the design
                backgroundColor: Colors.white.withOpacity(0.1),
                child: CircleAvatar(
                  radius: 62,
                  backgroundImage: AssetImage(userData['image']),
                ),
              ),
              const SizedBox(height: 20),

              // 3. User Name
              Text(
                userData['name'],
                style: GoogleFonts.poltawskiNowy(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              // 4. View Profile Button
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 20,
                ),
                label: const Text(
                  "View Profile",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.15),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // 5. Settings List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Setting",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      _buildSettingItem(
                        Icons.image_outlined,
                        "View Media, Files & Links",
                        onTap: () => Get.to(
                          () => MediaGalleryScreen(),
                        ), // Add the navigation here
                      ),
                      _buildSettingItem(
                        Icons.delete_outline,
                        "Delete Chat",
                        onTap: () => _showActionSheet(
                          title: "Are you sure you want to remove all chats?",
                          subtitle:
                              "This will permanently delete all messages in this chat. You won’t be able to recover them.",
                          actionText: "Delete",
                          accentColor: Colors.redAccent,
                          bubbleIcon: Icons.delete_sweep,
                          onPrimaryTap: () {
                            if (Get.isRegistered<ChatController>()) {
                              Get.find<ChatController>().messages.clear();
                            }
                            Get.back();
                          },
                        ),
                      ),
                      _buildSettingItem(
                        Icons.error_outline,
                        "Report",
                        onTap: () => _showActionSheet(
                          title: "Report User?",
                          subtitle:
                              "Do you want to report this user? Our team will review the logs for safety.",
                          actionText: "Report",
                          accentColor: const Color(
                            0xFFD455E9,
                          ), // Standard purple
                          bubbleIcon: Icons.report_problem_outlined,
                          onPrimaryTap: () => Get.back(),
                        ),
                      ),
                      _buildSettingItem(
                        Icons.block_flipped,
                        "Block",
                        onTap: () => _showActionSheet(
                          title: "Block User?",
                          subtitle:
                              "You will no longer receive messages or be able to view this profile.",
                          actionText: "Block",
                          accentColor: Colors.redAccent,
                          bubbleIcon: Icons.block_flipped,
                          onPrimaryTap: () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build the setting rows exactly like your image
  // Add "VoidCallback? onTap" to the parameters
  Widget _buildSettingItem(IconData icon, String title, {VoidCallback? onTap}) {
    return InkWell(
      // Use InkWell or GestureDetector to make it clickable
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showActionBottomSheet({
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E20), // Matches your attachment menu color
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDestructive
                      ? Colors.redAccent
                      : Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  actionText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Cancel Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showActionSheet({
    required String title,
    required String subtitle,
    required String actionText,
    required Color accentColor,
    required IconData bubbleIcon,
    required VoidCallback onPrimaryTap,
  }) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Color(0xFF0F0118),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- DRAG HANDLE ---
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 25),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),

            // --- BODY TEXT ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // --- BUTTON SECTION ---
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFD455E9),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 93, 93),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // 1. Close BottomSheet
                      Get.back();

                      // 2. Perform the logic (Delete/Block/Report)
                      onPrimaryTap();

                      // 3. Show Top Snackbar
                      Get.snackbar(
                        "Action Performed",
                        "$actionText successfully completed.",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.white.withOpacity(
                          0.1,
                        ), // Translucent background
                        colorText: Colors.white,
                        icon: Icon(bubbleIcon, color: accentColor),

                        // --- USE THESE TWO INSTEAD OF backdropBlur ---
                        overlayBlur:
                            3.0, // This creates the blur effect on the background
                        overlayColor: Colors.black.withOpacity(
                          0.2,
                        ), // Darkens the background slightly
                        // Edge definition for glass look
                        borderColor: Colors.white.withOpacity(0.2),
                        borderWidth: 1,

                        margin: const EdgeInsets.all(15),
                        borderRadius: 15,
                        duration: const Duration(seconds: 3),
                        isDismissible: true,
                        forwardAnimationCurve: Curves.easeOutBack,
                      );
                    },
                    child: Text(
                      actionText,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
    );
  }

  // Helper for the Floating Bubbles
  Widget _buildBubbleIcon(IconData icon, Color color, {double size = 24}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E20),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    );
  }
}
