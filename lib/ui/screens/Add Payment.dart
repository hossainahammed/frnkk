import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'PaymentSummaryScreen.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  String selectedMethod = "Stripe";

  @override
  Widget build(BuildContext context) {
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
          "Add Payment",
          style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        width: 1.sw, // Responsive Width
        height: 1.sh, // Responsive Height
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                "Select the payment method you want to use.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'Serif',
                ),
              ),
              SizedBox(height: 30.h),

              /// PAYMENT METHOD CARD
              GestureDetector(
                onTap: () => setState(() => selectedMethod = "Stripe"),
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: selectedMethod == "Stripe"
                          ? const Color(0xFFD458FF)
                          : Colors.white12,
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "stripe",
                        style: TextStyle(
                          color: const Color(0xFF6772E5),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        "Stripe",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFD458FF), width: 2.w),
                        ),
                        child: Center(
                          child: Container(
                            height: 12.h,
                            width: 12.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedMethod == "Stripe"
                                  ? const Color(0xFFD458FF)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              /// ADD BUTTON (Fixed Error)
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    final args = Get.arguments as Map<String, String>? ?? {};
                    final priceString = args['price'] ?? '\$0.00';
                    final title = args['title'] ?? 'Monthly';


                    double parsedAmount = double.tryParse(priceString.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;

                    Get.to(
                          () => PaymentSummaryScreen(
                        planType: title,
                        amount: parsedAmount,
                      ),
                      transition: Transition.fade,
                      duration: const Duration(milliseconds: 300),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD458FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                  ),
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}