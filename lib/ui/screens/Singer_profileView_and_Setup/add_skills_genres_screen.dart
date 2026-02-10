import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:frnkk/controllers/singer_profile_controller.dart';

class AddSkillsGenresScreen extends StatelessWidget {
  const AddSkillsGenresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SingerProfileController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: const Color(0xFF080322),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Add Skill & Genres",
          style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Column(
            children: [
              SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Language Section ---
                      _buildEditSection(
                        title: "Language",
                        child: Column(
                          children: [
                            _buildInputField("Title *", "e.g. English", controller.newLanguageController),
                            SizedBox(height: 15.h),
                            _buildInputField(
                              "Level *",
                              "e.g. 90%",
                              controller.newLevelController,
                              onAdd: () => controller.addLanguage(), // Triggers the save logic
                            ),
                            SizedBox(height: 15.h),
                            Obx(() => _buildRemovableTags(
                              controller.artistData.value.languages.map((e) => e['name'] as String).toList(),
                                  (val) => controller.removeLanguage(val),
                            )),
                          ],
                        ),
                      ),

                      SizedBox(height: 25.h),

                      // --- Skill Section ---
                      _buildEditSection(
                        title: "Skill",
                        child: Column(
                          children: [
                            _buildInputField(
                              "Title *",
                              "Vocalist",
                              controller.newSkillController,
                              onAdd: () => controller.addSkill(controller.newSkillController.text),
                            ),
                            SizedBox(height: 15.h),
                            Obx(() => _buildRemovableTags(
                              controller.artistData.value.skills,
                                  (val) => controller.removeSkill(val),
                            )),
                          ],
                        ),
                      ),

                      SizedBox(height: 25.h),

                      // --- Genres Section ---
                      _buildEditSection(
                        title: "Genres",
                        child: Column(
                          children: [
                            _buildInputField(
                              "Title *",
                              "Rock",
                              controller.newGenreController,
                              onAdd: () => controller.addGenre(controller.newGenreController.text),
                            ),
                            SizedBox(height: 15.h),
                            Obx(() => _buildRemovableTags(
                              controller.artistData.value.genres,
                                  (val) => controller.removeGenre(val),
                            )),
                          ],
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // --- Save Button ---
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD458FF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
                          ),
                          child: Text("Save", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
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

  Widget _buildEditSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white10),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController textController, {VoidCallback? onAdd}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
        SizedBox(height: 8.h),
        TextField(
          controller: textController,
          onSubmitted: (_) => onAdd?.call(), // Adds when user presses 'Enter'
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white24),
            filled: true,
            fillColor: const Color(0xFF0D0826),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            suffixIcon: onAdd != null
                ? IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFFD458FF)),
              onPressed: onAdd,
            )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildRemovableTags(List<String> items, Function(String) onRemove) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: items.map((item) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item, style: const TextStyle(color: Colors.white, fontSize: 13)),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => onRemove(item),
              child: Icon(Icons.cancel, size: 18.sp, color: const Color(0xFFD458FF)),
            ),
          ],
        ),
      )).toList(),
    );
  }
}