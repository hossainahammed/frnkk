import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/GigController.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/GigDetailsScreen.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';

class CreateNewGigScreen extends StatelessWidget {
  const CreateNewGigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We use Get.put here to initialize the controller if it doesn't exist
    //final controller = Get.put(GigController());
    final controller = Get.find<GigController>();

    return Scaffold(
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Container(
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [Color(0xFF2D0A4E), Color(0xFF080322)],
            //   ),
            // ),
            child: SafeArea(
              child: Column(
                children: [
                  // In the AppBar title
                  Obx(() => Text(
                      controller.editingIndex.value == -1 ? "Create New Gig" : "Edit Gig",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)
                  )),

          // In the Publish Button
                  Obx(() => Text(
                      controller.editingIndex.value == -1 ? "Published" : "Update Gig",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  )),
                //  _buildAppBar("Create New Gig"),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Designation",
                              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                          SizedBox(height: 12.h),

                          // Card 1: Main Info
                          _buildFormCard([
                            _buildLabel("Title *"),
                            _buildTextField(controller.titleController, "The Bleckest Day"),
                            _buildLabel("Name *"),
                            _buildTextField(controller.nameController, "Classical"),
                            _buildLabel("Location *"),
                            _buildTextField(controller.locationController, "Classical"),

                            _buildLabel("Skills*"),
                            TextField(
                              controller: controller.skillInputController,
                              onSubmitted: (val) => controller.addSkill(val),
                              style: const TextStyle(color: Colors.white),
                              decoration: _inputStyle("Add skill and press enter"),
                            ),
                            SizedBox(height: 10.h),
                            Obx(() => Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: controller.skills.map((skill) =>
                                  _buildSkillChip(skill, () => controller.removeSkill(skill))).toList(),
                            )),

                            SizedBox(height: 20.h),
                            _buildLabel("Event Type*"),
                            Row(
                              children: [
                                _buildSmallInput(controller.eventTypeInputController, "Party"),
                                SizedBox(width: 8.w),
                                _buildSmallInput(controller.eventPriceInputController, "300 \$"),
                                SizedBox(width: 8.w),
                                _buildAddButton(() => controller.addEventType()),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Obx(() => Wrap(
                              spacing: 8.w,
                              children: controller.eventTypes.asMap().entries.map((e) =>
                                  _buildEventChip("${e.value['type']} ${e.value['price']}",
                                          () => controller.removeEventType(e.key))
                              ).toList(),
                            )),
                          ]),

                          SizedBox(height: 20.h),

                          // Card 2: Included & Excluded (NOW FULLY BINDED)
                          _buildFormCard([
                            _buildLabel("Included *"),
                            _buildTextField(controller.includedController, "What's included in your gig?", maxLines: 4),
                            _buildLabel("Excluded *"),
                            _buildTextField(controller.excludedController, "What's not included?", maxLines: 4),
                          ]),

                          SizedBox(height: 20.h),
                          _buildLabel("Gig Image *"),
                          GestureDetector(
                            onTap: () => controller.pickImage(),
                            child: Obx(() => _buildUploadBox(controller.selectedImagePath.value)),
                          ),
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildPublishButton(() {
        // Validation check
        if (controller.titleController.text.isEmpty) {
          Get.snackbar("Required", "Please fill in the Gig Title",
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        } else {
          //Get.to(() => const GigDetailsScreen());
          controller.publishGig(); // This handles adding to list and navigating to details
        }
      }),
    );
  }

  // --- Helpers (Styles remain exactly as you designed them) ---

  Widget _buildAppBar(String title) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Row(children: [
        IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Get.back()),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _buildFormCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _buildLabel(String text) => Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 13.sp)));

  Widget _buildTextField(TextEditingController ctrl, String hint, {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: _inputStyle(hint),
      ),
    );
  }

  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white24),
      filled: true,
      fillColor: const Color(0xFF130E2D),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.white12)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.white12)),
    );
  }

  Widget _buildSkillChip(String label, VoidCallback onRemove) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFD458FF))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        SizedBox(width: 8.w),
        GestureDetector(onTap: onRemove, child: Icon(Icons.cancel, color: const Color(0xFFD458FF), size: 16.sp)),
      ]),
    );
  }

  Widget _buildEventChip(String label, VoidCallback onRemove) {
    return Container(
      margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFD458FF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
          SizedBox(width: 8.w),
          GestureDetector(onTap: onRemove, child: Icon(Icons.cancel, color: const Color(0xFFD458FF), size: 16.sp)),
        ],
      ),
    );
  }

  Widget _buildSmallInput(TextEditingController ctrl, String hint) {
    return Expanded(child: TextField(controller: ctrl, style: const TextStyle(color: Colors.white), decoration: _inputStyle(hint)));
  }

  Widget _buildAddButton(VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD458FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
      child: const Text("Add New", style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildUploadBox(String imagePath) {
    return Container(
      width: double.infinity,
      height: 120.h,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white10)),
      child: imagePath.isEmpty
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.image_outlined, color: const Color(0xFFD458FF), size: 30.sp),
        Text("Click to upload Image", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
      ])
          : ClipRRect(borderRadius: BorderRadius.circular(12.r), child: Image.file(File(imagePath), fit: BoxFit.cover)),
    );
  }

  Widget _buildPublishButton(VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 48.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD458FF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r))),
        child: const Text("Published", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}