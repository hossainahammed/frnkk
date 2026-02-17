import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/singer_profile_PortfolioController.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';


class AddPortfolioScreen extends StatelessWidget {
  const AddPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(PortfolioController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            AppDecorations.buildFullBackground(),
            SafeArea(
              child: Column(
                children: [
                  _buildAppBar("Add Portfolio"),
                  _buildCustomTabBar(),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildAudioPage(controller),
                        _buildAlbumPage(controller),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildSaveButton(),
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(25.r),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: "Audio Upload"),
            Tab(text: "Album Upload"),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioPage(PortfolioController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          _buildTextField("Title *", "The Bleckest Day"),
          _buildTextField("Type *", "Classical"),
          _buildTextField("Artist Name *", "Classical"),
          _buildTextField("Lyrics *", "Enter lyrics here...", maxLines: 5),
          // Pass the controller and the pick function
          Obx(() => _buildUploadBox(
            label: "Audio File *",
            fileName: controller.audioFileName.value,
            onTap: () => controller.pickAudioFile(false),
          )),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildAlbumPage(PortfolioController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          _buildSectionTitle("Album"),
          _buildTextField("Title *", "The Bleckest Day"),
          _buildTextField("Type *", "Classical"),
          _buildTextField("Artist Name *", "Classical"),
          // Pass the controller and the pick function
          Obx(() => _buildUploadBox(
            label: "Audio Album *",
            fileName: controller.albumFileName.value,
            onTap: () => controller.pickAudioFile(true),
          )),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  // Updated Upload Box with GestureDetector
  Widget _buildUploadBox({required String label, required String fileName, required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white, fontSize: 15.sp)),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              children: [
                Icon(Icons.library_music, color: const Color(0xFFD458FF), size: 30.sp),
                SizedBox(height: 10.h),
                Text(
                  fileName.isEmpty ? "Click to upload Audio" : fileName,
                  style: TextStyle(
                      color: fileName.isEmpty ? Colors.white : const Color(0xFFD458FF),
                      fontSize: 14.sp,
                      fontWeight: fileName.isEmpty ? FontWeight.normal : FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                if (fileName.isEmpty) ...[
                  SizedBox(height: 5.h),
                  Text("Mp3, Mp4 up to 50 MB", style: TextStyle(color: Colors.white38, fontSize: 12.sp)),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ... (Keep your existing _buildAppBar, _buildTextField, _buildSectionTitle, and _buildSaveButton)

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
      padding: EdgeInsets.only(bottom: 15.h),
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