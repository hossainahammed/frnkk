import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/AddBioScreen.dart';
import 'package:get/get.dart';
import 'package:frnkk/controllers/singer_profile_controller.dart';

class ExperienceTabView extends StatelessWidget {
  const ExperienceTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SingerProfileController>();

    // This is the core content of your view
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Header Section ---
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // FIXED: Expanded prevents the Row from pushing past screen width
                  Expanded(
                    child: Text("My Professional Journey",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => const AddBioScreen()),
                    child: Icon(Icons.edit_note, color: const Color(0xFFD458FF), size: 24.sp),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1433),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.mic, color: Color(0xFFD458FF), size: 18),
                    SizedBox(width: 8.w),
                    const Text("Singer . Songwriter", style: TextStyle(color: Colors.white70)),
                    const Spacer(),
                    // FIXED: Replaced VerticalDivider (the cause of the 774px overflow)
                    Container(width: 1, height: 16.h, color: Colors.white24),
                    const Spacer(),
                    const Text("4 year+ track", style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.experienceList.length,
          itemBuilder: (context, index) => _buildTimelineItem(controller.experienceList[index]),
        ),
        SizedBox(height: 20.h),
        Text("Experience Status", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 15.h),
        Row(
          children: [
            _buildStatusCard("120 +", "Song Record",''),
            SizedBox(width: 12.w),
            _buildStatusCard("20 +", "Live Performance",''),
          ],
        ),
      ],
    );

    // CHECK: If this is a standalone screen, wrap it in Scaffold/ScrollView
    // If it's in the Profile Tab, just return the content
    bool isStandalone = Get.currentRoute == '/ExperienceTabView';

    if (isStandalone) {
      return Scaffold(
        backgroundColor: const Color(0xFF080322),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Experience", style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: content,
        ),
      );
    }

    return content;
  }
  Widget _buildTimelineItem(Map<String, String> data) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Text(data['year']!, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
              SizedBox(height: 8.h),
              Expanded(
                child: Container(
                  width: 2.w,
                  color: const Color(0xFFD458FF),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 10.r,
                      width: 10.r,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFD458FF), width: 2),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['role']!, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(Icons.groups, color: Color(0xFFD458FF), size: 16),
                      SizedBox(width: 4.w),
                      Text(data['project']!, style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['duration']!, style: TextStyle(color: Colors.white54, fontSize: 12.sp)),
                        SizedBox(height: 4.h),
                        Text(data['description']!, style: TextStyle(color: Colors.white70, fontSize: 13.sp, height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String count, String label, String genres) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0826),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.mic, color: Color(0xFFD458FF), size: 18),
                SizedBox(width: 8.w),
                Text(count, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 4.h),
            Text(label, style: TextStyle(color: Colors.white70, fontSize: 12.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
            SizedBox(height: 4.h),
            Text(genres, style: TextStyle(color: Colors.white38, fontSize: 11.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}