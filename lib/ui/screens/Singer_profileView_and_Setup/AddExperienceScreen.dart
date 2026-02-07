import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddExperienceScreen extends StatelessWidget {
  const AddExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D0A4E), // Deep Purple Top
              Color(0xFF080322), // Dark Navy Bottom
            ],
          ),
        ),
        child: SafeArea(
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
                    Text(
                      "Add Experience",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // --- Scrollable Form ---
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1: Job Titles
                      _buildSectionCard([
                        _buildLabel("Professional Job Title*"),
                        _buildDropdownField("Singer"),
                        SizedBox(height: 16.h),
                        _buildLabel("Additional"),
                        _buildDropdownField("Songwriter"),
                      ]),

                      SizedBox(height: 24.h),
                      Text("Work",
                          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.h),

                      // Section 2: Work Details
                      _buildSectionCard([
                        _buildLabel("Job Title *"),
                        _buildTextField("Lead Vocalist"),
                        SizedBox(height: 16.h),
                        _buildLabel("Workplace*"),
                        _buildTextField("Independent Studio Project"),
                        SizedBox(height: 12.h),

                        // Checkbox Row
                        Row(
                          children: [
                            Text("Currently work here",
                                style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
                            const Spacer(),
                            SizedBox(
                              height: 24.w,
                              width: 24.w,
                              child: Checkbox(
                                value: true,
                                onChanged: (v) {},
                                activeColor: const Color(0xFFD458FF),
                                side: const BorderSide(color: Colors.white38),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Start Date
                        _buildLabel("Start Date"),
                        _buildDateRow("2022", "Jul", "12"),
                        SizedBox(height: 16.h),

                        // End Date
                        _buildLabel("End Date"),
                        _buildDateRow("2022", "Jul", "12"),
                        SizedBox(height: 16.h),

                        // Description
                        _buildLabel("Description"),
                        _buildTextField("Enter", maxLines: 4),
                      ]),

                      SizedBox(height: 100.h), // Padding for the bottom button
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // --- Sticky Save Button ---
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
            elevation: 0,
          ),
          child: Text("Save",
              style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  // --- UI Component Helpers ---

  Widget _buildSectionCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text,
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500)),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.white12),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String value) {
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
          items: [value].map((String val) => DropdownMenuItem(
              value: val,
              child: Text(val, style: const TextStyle(color: Colors.white))
          )).toList(),
          onChanged: (v) {},
        ),
      ),
    );
  }

  Widget _buildDateRow(String y, String m, String d) {
    return Row(
      children: [
        _buildDateBox(y),
        SizedBox(width: 10.w),
        _buildDateBox(m),
        SizedBox(width: 10.w),
        _buildDateBox(d),
      ],
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
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}