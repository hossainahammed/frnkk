import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/profile_controller.dart';
import 'package:frnkk/ui/screens/Settings/NotificationScreen.dart';
import 'package:frnkk/ui/screens/Settings/PaymentHistoryScreen.dart';
import 'package:frnkk/ui/screens/Settings/SecurityScreen.dart';
import 'package:frnkk/ui/screens/Settings/contact_us_screenn.dart';
import 'package:frnkk/ui/screens/Settings/personal_data_screen.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/singer_profile_screen.dart';
import 'package:frnkk/ui/screens/Subscription/SubscriptionScreen.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      // 1. Keep this true so the background decoration fills the status bar/appbar area
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        // 2. Keep transparent so the background shows through
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          // This fills the whole screen, including behind the AppBar
          AppDecorations.buildFullBackground(),

          // 3. Use a Column to separate the AppBar space from the Scrollable content
          Column(
            children: [
              // This empty box pushes the scrollable area down exactly below the AppBar
              SizedBox(
                height:
                    AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top,
              ),

              // The Rest is the scrollable area
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundImage: const AssetImage(
                              'assets/images/Rectangle.png',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Obx(
                        () => Text(
                          controller.userName.value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.userEmail.value,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: OutlinedButton(
                          onPressed: () =>
                              Get.to(() => const SingerProfileScreen()),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFD458FF)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                          ),
                          child: Text(
                            "My Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      _buildPlanStatusCard(controller),
                      SizedBox(height: 30.h),
                      _buildSectionTitle("Personal Info"),
                      _buildMenuItem(
                        'assets/images/profile_Icon/user-circle.png',
                        "Personal Data",
                        onTap: () => Get.to(() => const PersonalDataScreen()),
                      ),
                      _buildMenuItem(
                        'assets/images/profile_Icon/Subscription.png',
                        "Subscription ",
                        onTap: () => Get.to(() => const SubscriptionScreen()),
                      ),
                      _buildMenuItem(
                        'assets/images/profile_Icon/credit-card-03.png',
                        "Payment History",
                        onTap: () => Get.to(() => const PaymentHistoryScreen()),
                      ),
                      SizedBox(height: 20.h),
                      _buildSectionTitle("General"),
                      _buildMenuItem(
                        'assets/images/profile_Icon/bell-01.png',
                        "Notification Setting",
                        onTap: () => Get.to(() => const NotificationScreen()),
                      ),
                      _buildMenuItem(
                        'assets/images/profile_Icon/security.png',
                        "Security",
                        onTap: () => Get.to(() => const SecurityScreen()),
                      ),
                      SizedBox(height: 20.h),
                      _buildSectionTitle("About"),
                      _buildMenuItem(
                        'assets/images/profile_Icon/Contact_us.png',
                        "Contact Us",
                        onTap: () => Get.to(() => const ContactUsScreen()),
                      ),
                      _buildMenuItem(
                        'assets/images/profile_Icon/locked.png',
                        "Privacy & Policy",
                      ),
                      _buildMenuItem(
                        'assets/images/profile_Icon/log-out-05.png',
                        "Logout",
                        isLogout: true,
                        onTap: () => controller.showLogoutBottomSheet(),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Helper Methods ---

  Widget _buildPlanStatusCard(ProfileController controller) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Plan Status",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.onUpgradeTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5E5E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  child: Text(
                    controller.planStatus.value == "Monthly"
                        ? "Upgrade"
                        : "Manage",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    controller.planStatus.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  "Plan expire: ${controller.planExpiry.value}",
                  style: TextStyle(color: Colors.white54, fontSize: 13.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, top: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    dynamic icon,
    String title, {
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    Widget leading;
    if (icon is IconData) {
      leading = Icon(
        icon,
        color: isLogout ? const Color(0xFFFF5E5E) : Colors.white,
        size: 24.sp,
      );
    } else if (icon is String) {
      leading = Image.asset(
        icon,
        width: 24.sp,
        height: 24.sp,
        color: isLogout ? const Color(0xFFFF5E5E) : Colors.white,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.error, color: Colors.red, size: 24.sp),
      );
    } else {
      leading = Icon(
        Icons.error,
        color: isLogout ? const Color(0xFFFF5E5E) : Colors.white,
        size: 24.sp,
      );
    }

    return ListTile(
      onTap: onTap ?? () {},
      contentPadding: EdgeInsets.zero,
      leading: leading,
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? const Color(0xFFFF5E5E) : Colors.white,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
