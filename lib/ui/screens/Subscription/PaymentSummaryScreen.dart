import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/profile_controller.dart';
import 'package:frnkk/routes/app_routes.dart';
import 'package:frnkk/ui/screens/Settings/profileScreen.dart';
import 'package:frnkk/ui/screens/Subscription/SuccessSubscriptionDialog.dart';
import 'package:get/get.dart';

class PaymentSummaryScreen extends StatelessWidget {
  final String planType;
  final double amount;

  const PaymentSummaryScreen({
    super.key,
    required this.planType,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    double tax = 1.99;
    double total = amount + tax;

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
          "Payment Summary",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.centerRight,
            radius: 1.5,
            colors: [Color(0xFF2D0B4D), Color(0xFF080322)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              _buildIncludedBox(),
              SizedBox(height: 30.h),

              // Billing Summary Box
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      planType,
                      style: TextStyle(
                        color: const Color(0xFFFF5E5E),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _priceRow("Amount", "\$${amount.toStringAsFixed(2)}"),
                    SizedBox(height: 15.h),
                    _priceRow("Tax", "\$${tax.toStringAsFixed(2)}"),
                    SizedBox(height: 15.h),
                    const Divider(color: Colors.white24, thickness: 1),
                    SizedBox(height: 15.h),
                    _priceRow(
                      "Total",
                      "\$${total.toStringAsFixed(2)}",
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _buildConfirmButton(),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildIncludedBox() {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              _featureRow("Unlimited Message"),
              SizedBox(height: 12.h),
              _featureRow("Unlimited Gig Post"),
              SizedBox(height: 12.h),
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
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
        Icon(Icons.check, color: Colors.white, size: 18.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD458FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        ),
        onPressed: () {

          final profileController = Get.isRegistered<ProfileController>()
              ? Get.find<ProfileController>()
              : Get.put(ProfileController());

          profileController.updatePlan(planType);
          final bool fromMainSwipe = Get.arguments?['fromMainSwipe'] ?? false;

          Get.dialog(SuccessSubscriptionDialog(fromMainSwipe: fromMainSwipe));

          // Get.dialog(const SuccessSubscriptionDialog());
        },
        child: Text(
          "Confirm Payment",
          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}

/// Success Dialog


