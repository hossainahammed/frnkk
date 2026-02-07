import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/Model/ArtistModel.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/add_skills_genres_screen.dart';
import 'package:frnkk/controllers/singer_profile_controller.dart';
import 'package:get/get.dart';

class SkillsAndGenresTabView extends StatelessWidget {
  final Artist data;
  const SkillsAndGenresTabView({super.key, required this.data});

  @override
  // Inside SkillsAndGenresTabView.dart

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SingerProfileController>();

    return Obx(() {

      final data = controller.artistData.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Language"),
          SizedBox(height: 15.h),
          Wrap(
            spacing: 20.w,
            runSpacing: 20.h,
            children: data.languages.map((lang) => _buildLanguageProgress(lang['name'], lang['value'])).toList(),
          ),

          SizedBox(height: 30.h),
          _buildSectionHeader("Skill"),
          SizedBox(height: 15.h),
          _buildTagWrap(data.skills),

          SizedBox(height: 30.h),
          _buildSectionHeader("Genres"),
          SizedBox(height: 15.h),
          _buildTagWrap(data.genres),
        ],
      );
    });
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
        IconButton(
          onPressed: () => Get.to(() => const AddSkillsGenresScreen()),
          icon: Icon(Icons.edit_note, color: const Color(0xFFD458FF), size: 24.sp),
        )
      ],
    );
  }

  Widget _buildLanguageProgress(String name, double value) {
    return SizedBox(
      width: Get.width * 0.42,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
              Text("${(value * 100).toInt()}%",
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
            ],
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.white.withOpacity(0.1),
            color: const Color(0xFFD458FF),
            borderRadius: BorderRadius.circular(10.r),
            minHeight: 4.h,
          ),
        ],
      ),
    );
  }

  Widget _buildTagWrap(List<String> items) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: items
          .map((item) => Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Text(item, style: TextStyle(color: Colors.white, fontSize: 13.sp)),
      ))
          .toList(),
    );
  }
}