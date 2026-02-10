import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/NotificationController.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: const Color(0xFF080322),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Notification",
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Column(
            children: [
              SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top),
              Expanded(
                child: Container(
                  height: 1.sh,
                  width: 1.sw,
                  // decoration: const BoxDecoration(
                  //   gradient: RadialGradient(
                  //     center: Alignment.centerRight,
                  //     radius: 1.5,
                  //     colors: [Color(0xFF2D0B4D), Color(0xFF080322)],
                  //   ),
                  // ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                    child: Column(
                      children: [
                        _buildNotificationToggle("All Notification", controller.allNotifications),
                        _buildNotificationToggle("Connection", controller.connectionNotify),
                        _buildNotificationToggle("Match", controller.matchNotify),
                        _buildNotificationToggle("Message", controller.messageNotify),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(String title, RxBool state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Obx(() => CupertinoSwitch(
            activeColor: const Color(0xFFFF5E5E), // Matches the reddish toggle in your image
            trackColor: Colors.white24,
            value: state.value,
            onChanged: (value) => state.value = value,
          )),
        ],
      ),
    );
  }
}