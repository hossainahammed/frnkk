import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/Add%20Payment.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionDetailScreen extends StatelessWidget {
  const SubscriptionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final args = Get.arguments as Map<String, String>? ?? {};
    final title = args['title'] ?? 'Subscription';
    final price = args['price'] ?? '\$0.00';
    final originalPrice = args['originalPrice'] ?? '\$0.00';
    final discount = args['discount'] ?? '0%';

    return Scaffold(
      backgroundColor: const Color(0xFF080322),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Subscription",
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.centerRight,
            radius: 1.5,
            colors: [Color(0xFF2D0B4D), Color(0xFF080322)],
          ),
        ),
        child: SingleChildScrollView(

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Text(
                  '$title Membership',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Unlock the most powerful Music Network assistant',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 30.h),

                ImageIcon(
                  AssetImage('assets/images/Membership.png'),
                  color: Color(0xFFD458FF),
                  size: 50.sp,
                ),

                SizedBox(height: 20.h),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      originalPrice,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 24.sp,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' /Live',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      ' save $discount ',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 28.w),
                  ],
                ),

                SizedBox(height: 30.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Under this package, you will be entitled to those feature',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                _buildFeatureList(),

                //const Spacer(),
                SizedBox(height: 50.h),


                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => const AddPaymentScreen(),

                        arguments: {'title': title, 'price': price},
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 300),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD458FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Feature List',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        _bulletPoint("Unlimited Message"),
        _bulletPoint("Full match replays (30 days archive)"),
        _bulletPoint("Connection"),
        Padding(
          padding: EdgeInsets.only(left: 12.w, top: 4.h),
          child: Text(
            "Match and chat with people anywhere in the world.",
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Text(
            " • ",
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
          ),
        ],
      ),
    );
  }
}
