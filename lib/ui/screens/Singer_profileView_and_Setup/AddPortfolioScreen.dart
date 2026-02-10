import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';

class AddPortfolioScreen extends StatelessWidget {
  const AddPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Column(
            children: [
              Expanded(
                child: Container(
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
                        _buildAppBar("Add Portfolio"),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle("Audio"),
                                _buildTextField("Title *", "The Bleckest Day"),
                                _buildTextField("Type *", "Classical"),
                                _buildTextField("Artist Name *", "Classical"),
                                _buildTextField("Lyrics*", "[Verse 1]\nI stay out too late...", maxLines: 5),
                                _buildTextField("Artist Name *", ""),
                                _buildUploadBox(),

                                SizedBox(height: 30.h),

                                _buildSectionTitle("Album"),
                                _buildTextField("Title *", "The Bleckest Day"),
                                _buildTextField("Type *", "Classical"),
                                _buildTextField("Artist Name *", "Classical"),
                                _buildTextField("Artist Name *", "Classical"),
                                _buildTextField("Artist Name *", "Classical"),
                                _buildUploadBox(),

                                SizedBox(height: 100.h), // Space for button
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildSaveButton(),
    );
  }

  Widget _buildAppBar(String title) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Get.back()),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          SizedBox(height: 8.h),
          TextField(
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.white12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white12, style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          Icon(Icons.library_music_outlined, color: const Color(0xFFD458FF), size: 30.sp),
          SizedBox(height: 10.h),
          Text("Click to upload Audio", style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          SizedBox(height: 5.h),
          Text("Mp3, Mp4 up to 50 MB", style: TextStyle(color: Colors.white38, fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD458FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        ),
        child: const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}