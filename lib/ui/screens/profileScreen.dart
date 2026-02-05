import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/profile_controller.dart';
import 'package:frnkk/ui/screens/NotificationScreen.dart';
import 'package:frnkk/ui/screens/PaymentHistoryScreen.dart';
import 'package:frnkk/ui/screens/SecurityScreen.dart';
import 'package:frnkk/ui/screens/contact_us_screenn.dart';
import 'package:frnkk/ui/screens/personal_data_screen.dart';
import 'package:get/get.dart';

import 'Add Payment.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFF080322),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.centerRight,
            radius: 1.5,
            colors: [Color(0xFF2D0B4D), Color(0xFF080322)],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              Stack(
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: const AssetImage(
                      'assets/images/Rectangle.png',
                    ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: Container(
                  //     padding: EdgeInsets.all(6.r),
                  //     decoration: const BoxDecoration(
                  //       color: Color(0xFFFF5E5E),
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: ImageIcon(AssetImage('assets/images/profile_Icon/Vector.png'),color: Colors.white, size: 24.sp),
                  //   ),
                  // ),
                ],
              ),

              SizedBox(height: 16.h),
              Text(
                controller.userName.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                controller.userEmail.value,
                style: TextStyle(color: Colors.white54, fontSize: 14.sp),
              ),

              SizedBox(height: 30.h),

              _buildPlanStatusCard(controller),

              SizedBox(height: 30.h),

              _buildSectionTitle("Personal Info"),
              //_buildMenuItem(Icons.person_outline_outlined, "Personal Data"),
              _buildMenuItem(
                'assets/images/profile_Icon/user-circle.png',
                "Personal Data",
                onTap: () => Get.to(() => const PersonalDataScreen()),
              ),
              _buildMenuItem(
                'assets/images/profile_Icon/Subscription.png',
                "Subscription ",
                onTap: () => Get.to(() => const AddPaymentScreen()),
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
    );
  }

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

  // Widget _buildPlanStatusCard(ProfileController controller) {
  //   return Obx(() => Container(
  //     padding: EdgeInsets.all(16.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.08),
  //       borderRadius: BorderRadius.circular(16.r),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "Your Plan Status",
  //               style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
  //             ),
  //             // Hide upgrade button if they are already on a premium plan
  //             if (controller.planStatus.value == "Basic")
  //               ElevatedButton(
  //                 onPressed: controller.onUpgradeTap,
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: const Color(0xFFFF5E5E),
  //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
  //                   padding: EdgeInsets.symmetric(horizontal: 16.w),
  //                 ),
  //                 child: const Text("Upgrade", style: TextStyle(color: Colors.white)),
  //               ),
  //           ],
  //         ),
  //         SizedBox(height: 12.h),
  //         Row(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(8.r),
  //               ),
  //               child: Text(
  //                 controller.planStatus.value,
  //                 style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             SizedBox(width: 16.w),
  //             Text(
  //               "Plan expire: ${controller.planExpiry.value}",
  //               style: TextStyle(color: Colors.white54, fontSize: 13.sp),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   ));
  // }

  // Widget _buildPlanStatusCard(ProfileController controller) {
  //   return Container(
  //     padding: EdgeInsets.all(16.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.08),
  //       borderRadius: BorderRadius.circular(16.r),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "Your Plan Status",
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 16.sp,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             ElevatedButton(
  //               onPressed: controller.onUpgradeTap,
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: const Color(0xFFFF5E5E),
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
  //                 padding: EdgeInsets.symmetric(horizontal: 16.w),
  //               ),
  //               child: const Text("Upgrade", style: TextStyle(color: Colors.white)),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 12.h),
  //         Row(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(8.r),
  //               ),
  //               child: Text(
  //                 controller.planStatus.value,
  //                 style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             SizedBox(width: 16.w),
  //             Text(
  //               "Plan expire: ${controller.planExpiry.value}",
  //               style: TextStyle(color: Colors.white54, fontSize: 13.sp),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error, color: Colors.red, size: 24.sp);
        },
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
