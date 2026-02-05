import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/singer_profile_controller.dart';
import 'package:get/get.dart';

class SingerProfileScreen extends StatelessWidget {
  const SingerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SingerProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFF080322),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.h,
            pinned: true,
            backgroundColor: const Color(0xFF080322),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.white),
                onPressed: () {},
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/SingerProfile.png', fit: BoxFit.cover),
                  // Dark Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, const Color(0xFF080322).withOpacity(0.9)],
                      ),
                    ),
                  ),
                  // Profile Info Overlay
                  Positioned(
                    bottom: 20.h,
                    left: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Taylor Swift", style: TextStyle(color: Colors.white, fontSize: 32.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 10.w),
                            _buildStatusChip(),
                          ],
                        ),
                        Text("100 Connections", style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          // 2. Action Buttons & Tabs
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildActionButtons(),
                  SizedBox(height: 20.h),
                  _buildTabSection(controller),
                  SizedBox(height: 20.h),
                  _buildLatestRelease(),
                  SizedBox(height: 20.h),
                  _buildAboutSection(),
                  SizedBox(height: 20.h),
                  _buildAlbumHeader(),
                ],
              ),
            ),
          ),

          // 3. Horizontal Album List
          SliverToBoxAdapter(
            child: SizedBox(
              height: 250.h,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 20.w, bottom: 20.h),
                scrollDirection: Axis.horizontal,
                itemCount: controller.albums.length,
                itemBuilder: (context, index) => _buildAlbumCard(controller.albums[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.purpleAccent, width: 0.5),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 3, backgroundColor: Colors.amber),
          SizedBox(width: 6.w),
          Text("Available", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
        ],
      ),
    );
  }


  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD458FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                  ),
                  child: Text("Edit Profile",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Share button matches the purple accent in the image
            Container(
              height: 48.h,
              width: 48.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.share, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        // Implement the missing Add Gig Button
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFD458FF), width: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
            ),
            child: Text("Add Gig",
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    );
  }


  Widget _buildTabSection(SingerProfileController controller) {
    List<String> tabs = ["Bio", "Portfolio", "Skills & Genres", "Experience"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) => Obx(() {
          bool isSelected = controller.selectedTab.value == tab;
          return GestureDetector(
            onTap: () => controller.changeTab(tab),
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFD458FF).withOpacity(0.2) : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: isSelected ? const Color(0xFFD458FF) : Colors.transparent),
              ),
              child: Text(tab, style: TextStyle(color: isSelected ? Colors.white : Colors.white38)),
            ),
          );
        })).toList(),
      ),
    );
  }

  Widget _buildLatestRelease() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16.r)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("LATEST RELEASE", style: TextStyle(color: Colors.white38, fontSize: 12.sp, letterSpacing: 1.2)),
                SizedBox(height: 8.h),
                Text("Under Ocean Blvd", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                Text("Album • 2026", style: TextStyle(color: Colors.white38, fontSize: 14.sp)),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset('assets/images/music cover.png', width: 80.w, height: 80.w, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("About", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
            const Icon(Icons.edit_outlined, color: Color(0xFFD458FF), size: 20),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          "Warfaze is another popular music band in Bangladesh. It's known as the Pioneer Heavy Metal Band... see more",
          style: TextStyle(color: Colors.white70, fontSize: 14.sp, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildAlbumHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Albums", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
        Text("See all", style: TextStyle(color: Color(0xFFD458FF), fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildAlbumCard(Map<String, String> album) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(album['image']!, height: 160.h, width: 160.w, fit: BoxFit.cover),
          ),
          SizedBox(height: 8.h),
          Text(album['title']!, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
          Text(album['artist']!, style: TextStyle(color: Colors.white38, fontSize: 12.sp)),
        ],
      ),
    );
  }
}