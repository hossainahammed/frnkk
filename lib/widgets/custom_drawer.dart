import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/Settings/NotificationScreen.dart';
import 'package:frnkk/ui/screens/Settings/PaymentHistoryScreen.dart';
import 'package:frnkk/ui/screens/Settings/SecurityScreen.dart';
import 'package:frnkk/ui/screens/Settings/contact_us_screenn.dart';
import 'package:frnkk/ui/screens/Settings/personal_data_screen.dart';
import 'package:frnkk/ui/screens/Subscription/SubscriptionScreen.dart';
import 'package:get/get.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // 1. Drawer Shape (Only right side rounded)
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      backgroundColor: const Color(0xFF0B011D).withOpacity(0.95), // Deep dark
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),

          // 2. LOGO SECTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFD455E9), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Image(
                image: AssetImage("assets/images/drawer_image/LOGO.png"),
                height: 57,
                width: 105,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // 3. MENU LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: [
                _buildSectionHeader("Personal Info"),
                _buildDrawerItem(
                  Icons.person_outline,
                  "Personal Data",
                  onTap: () => Get.to(() => const PersonalDataScreen()),
                ),
                _buildDrawerItem(
                  Icons.workspace_premium_outlined,
                  "Subscription",
                  onTap: () => Get.to(() => const SubscriptionScreen()),
                ),
                _buildDrawerItem(
                  Icons.payment_outlined,
                  "Payment History",
                  onTap: () => Get.to(() => const PaymentHistoryScreen()),
                ),

                const SizedBox(height: 25),
                _buildSectionHeader("General"),
                _buildDrawerItem(
                  Icons.notifications_none_outlined,
                  "Notification Setting",
                  onTap: () => Get.to(() => const NotificationScreen()),
                ),
                _buildDrawerItem(
                  Icons.security_outlined,
                  "Security",
                  onTap: () => Get.to(() => const SecurityScreen()),
                ),

                const SizedBox(height: 25),
                _buildSectionHeader("About"),
                _buildDrawerItem(
                  Icons.mail_outline,
                  "Contact Us",
                  onTap: () => Get.to(() => const ContactUsScreen()),
                ),
                _buildDrawerItem(
                  Icons.lock_outline,
                  "Privacy & Policy",
                  onTap: () {},
                ),

                //const SizedBox(height: 20),
                _buildDrawerItem(
                  Icons.logout,
                  "Logout",
                  textColor: const Color(0xFFFF5C5C),
                  iconColor: const Color(0xFFFF5C5C),
                  onTap: () => _handleLogout(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Header Style (The smaller grey text)
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Individual Menu Item
  Widget _buildDrawerItem(
    IconData icon,
    String title, {
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 24),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onTap ?? () => Get.back(),
      minLeadingWidth: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      visualDensity: const VisualDensity(vertical: -1), // Tightens the list
    );
  }

  void _handleLogout() {
    // Show a dialog or just navigate
    //Get.back();
    Get.toNamed('/login');
  }
}
