import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/experience_controller.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddExperienceScreen extends StatelessWidget {
  const AddExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(ExperienceController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          SafeArea(
            child: Column(
              children: [
                // --- Custom AppBar ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                      Text("Add Experience",
                          style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section 1: Professional Titles
                        _buildSectionCard([
                          _buildLabel("Professional Job Title*"),
                          Obx(() => _buildDropdownField(
                            controller.selectedJob.value,
                            ["Singer", "Producer", "DJ", "Musician"],
                                (val) => controller.selectedJob.value = val!,
                          )),
                          SizedBox(height: 16.h),
                          _buildLabel("Additional"),
                          Obx(() => _buildDropdownField(
                            controller.selectedAdditional.value,
                            ["Songwriter", "Composer", "Engineer"],
                                (val) => controller.selectedAdditional.value = val!,
                          )),
                        ]),

                        SizedBox(height: 24.h),
                        Text("Work", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12.h),

                        // Section 2: Work Details
                        _buildSectionCard([
                          _buildLabel("Job Title *"),
                          _buildTextField("Lead Vocalist"),
                          SizedBox(height: 16.h),
                          _buildLabel("Workplace*"),
                          _buildTextField("Independent Studio Project"),
                          SizedBox(height: 12.h),

                          // Inter-actable Checkbox
                          Row(
                            children: [
                              Text("Currently work here", style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
                              const Spacer(),
                              Obx(() => Checkbox(
                                value: controller.isCurrentlyWorking.value,
                                onChanged: (v) => controller.isCurrentlyWorking.value = v!,
                                activeColor: const Color(0xFFD458FF),
                                side: const BorderSide(color: Colors.white38),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                              )),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Start Date (Clickable)
                          _buildLabel("Start Date"),
                          Obx(() => _buildDateRow(
                              controller.startDate.value,
                                  () => controller.pickDate(context, true)
                          )),
                          SizedBox(height: 16.h),

                          // End Date (Clickable & Conditional)
                          Obx(() => controller.isCurrentlyWorking.value
                              ? const SizedBox.shrink()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("End Date"),
                              _buildDateRow(
                                  controller.endDate.value,
                                      () => controller.pickDate(context, false)
                              ),
                              SizedBox(height: 16.h),
                            ],
                          )
                          ),

                          _buildLabel("Description"),
                          _buildTextField("Enter", maxLines: 4),
                        ]),
                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        height: 50.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD458FF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
          ),
          child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  // --- UI Component Helpers ---

  Widget _buildDropdownField(String value, List<String> items, Function(String?) onChanged) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF130E2D),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: const Color(0xFF1A1433),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
          items: items.map((String val) => DropdownMenuItem(
              value: val,
              child: Text(val, style: const TextStyle(color: Colors.white))
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDateRow(DateTime date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          _buildDateBox(DateFormat('yyyy').format(date)),
          SizedBox(width: 10.w),
          _buildDateBox(DateFormat('MMM').format(date)),
          SizedBox(width: 10.w),
          _buildDateBox(DateFormat('dd').format(date)),
        ],
      ),
    );
  }

  Widget _buildDateBox(String text) {
    return Expanded(
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
          color: const Color(0xFF130E2D),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.white12),
        ),
        child: Center(child: Text(text, style: const TextStyle(color: Colors.white))),
      ),
    );
  }

  // ... (Keep other helpers like _buildLabel, _buildTextField, _buildSectionCard as they were)
  Widget _buildSectionCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        filled: true,
        fillColor: const Color(0xFF130E2D),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.white12)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.white12)),
      ),
    );
  }
}