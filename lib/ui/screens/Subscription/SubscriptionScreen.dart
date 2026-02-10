import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/Subscription/SubscriptionDetailScreen.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  // 0 for Monthly, 1 for Yearly
  int selectedPlan = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFF080322),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(), // Navigates back to previous screen
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Container(
            width: double.infinity,
            // decoration: const BoxDecoration(
            //   gradient: RadialGradient(
            //     center: Alignment.centerRight,
            //     radius: 1.5,
            //     colors: [Color(0xFF2D0B4D), Color(0xFF080322)],
            //   ),
            // ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 80.h),
                  Text(
                    'Subscription',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Unlock the most powerful Music\nNetwork assistant',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  /// FEATURES BOX
                  _buildFeaturesBox(),

                  SizedBox(height: 40.h),
                  /// PLAN SELECTION (Equal Height Cards)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildPlanCard(
                          index: 0,
                          title: "Monthly",
                          price: "\$20.00",
                          footer: "Billed Monthly",
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildPlanCard(
                          index: 1,
                          title: "Yearly",
                          price: "\$200.00",
                          footer: "Free 1 Week Trial",
                          hasDiscount: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  /// const Spacer(),

                  /// CONTINUE BUTTON
                  _buildContinueButton(),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesBox() {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              _featureRow("Unlimited Message"),
              SizedBox(height: 16.h),
              _featureRow("Unlimited Gig Post"),
              SizedBox(height: 16.h),
              _featureRow(
                "Connection",
                subtitle: "Match and chat with people anywhere in the world.",
              ),
            ],
          ),
        ),
        Positioned(
          top: -15.h,
          child: Container(
            height: 30.h,
            width: 150.w,
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              textAlign: TextAlign.center,
              "Included with",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _featureRow(String title, {String? subtitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, color: Colors.white, size: 20.sp),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCard({
    required int index,
    required String title,
    required String price,
    required String footer,
    bool hasDiscount = false,
  }) {
    bool isSelected = selectedPlan == index;

    return GestureDetector(
      onTap: () => setState(() => selectedPlan = index),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: 147.h,
              minWidth: 187.w,
              maxHeight: 170.h,
            ),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? const Color(0xFFD458FF) : Colors.white10,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFFD458FF)
                            : Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      price,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFFD458FF)
                            : Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    if (hasDiscount)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(
                            12.r,
                          ),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Text(
                          "Save \$40.00",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      SizedBox(height: 24.h),
                  ],
                ),
                Text(
                  footer,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFFD458FF) : Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Positioned(
              top: -3.h,
              right: -3.w,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFD458FF),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(2.w),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: () {
          // 1. Capture the flag that came from the previous screen (MainSwipePage)
          final bool fromMainSwipe = Get.arguments?['fromMainSwipe'] ?? false;

          // 2. Prepare your plan arguments
          Map<String, dynamic> arguments; // Use dynamic to allow bool and String
          if (selectedPlan == 0) {
            arguments = {
              "title": "Monthly",
              "price": "\$20.00",
              "originalPrice": "\$25.00",
              "discount": "20%",
            };
          } else {
            arguments = {
              "title": "Yearly",
              "price": "\$200.00",
              "originalPrice": "\$240.00",
              "discount": " 40.00%",
            };
          }

          // 3. IMPORTANT: Add the flag back into the map so the NEXT screen gets it
          arguments['fromMainSwipe'] = fromMainSwipe;

          // Use GetX for navigation
          Get.to(
                () => const SubscriptionDetailScreen(),
            arguments: arguments,
            transition: Transition.fade,
            duration: const Duration(milliseconds: 300),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD458FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          elevation: 0,
        ),
        child: Text(
          "Continue – ${selectedPlan == 0 ? '\$20.00' : '\$200.00'} total",
          style: GoogleFonts.poltawskiNowy(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // Widget _buildContinueButton() {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 56.h,
  //     child: ElevatedButton(
  //       onPressed: () {
  //         Map<String, String> arguments;
  //         if (selectedPlan == 0) {
  //           arguments = {
  //             "title": "Monthly",
  //             "price": "\$20.00",
  //             "originalPrice": "\$25.00",
  //             "discount": "20%",
  //           };
  //         } else {
  //           arguments = {
  //             "title": "Yearly",
  //             "price": "\$200.00",
  //             "originalPrice": "\$240.00",
  //             "discount": " 40.00%",
  //           };
  //         }
  //
  //         // Use GetX for navigation
  //         Get.to(
  //           () => const SubscriptionDetailScreen(),
  //           arguments: arguments,
  //           transition: Transition.fade, // Optional: Add smooth transition
  //           duration: const Duration(milliseconds: 300),
  //         );
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color(0xFFD458FF),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(30.r), // Responsive radius
  //         ),
  //         elevation: 0,
  //       ),
  //       child: Text(
  //         "Continue – ${selectedPlan == 0 ? '\$20.00' : '\$200.00'} total",
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 18.sp, // Responsive font size
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
