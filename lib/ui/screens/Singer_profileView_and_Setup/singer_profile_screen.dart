import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/singer_profile_controller.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/AddGigScreen.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/EditProfileScreen.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/ExperienceTabView.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/ProfilePhotoChangeScreen.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/SingerProfilePortfolioSelfViewScreen.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/skills_and_genres_tab_view.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';

class SingerProfileScreen extends StatelessWidget {
  const SingerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SingerProfileController());

    return Scaffold(
      //backgroundColor: const Color(0xFF080322),
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          CustomScrollView(
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
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: IconButton(
                      icon: ImageIcon(
                        const AssetImage('assets/images/profile_Icon/Vector.png'),
                        color: const Color(0xFFD458FF),
                        size: 24.sp,
                      ),
                      onPressed: () => Get.to(() => const ProfilePhotoChangeScreen()),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/SingerProfile.png',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              const Color(0xFF080322).withOpacity(0.9),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.h,
                        left: 20.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Taylor Swift",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                _buildStatusChip(),
                              ],
                            ),
                            Text(
                              "100 Connections",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Action Buttons Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      _buildActionButtons(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),

              // 3. Tab Navigation Section (Full Width)
              SliverToBoxAdapter(
                child: _buildTabSection(controller),
              ),

              // 4. MAIN DYNAMIC CONTENT AREA
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Obx(() {
                    if (controller.selectedTab.value == "Skills & Genres") {
                      return Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: SkillsAndGenresTabView(
                          data: controller.artistData.value,
                        ),
                      );
                    } else if (controller.selectedTab.value == "Portfolio") {
                      return Column(
                        children: [
                          SizedBox(height: 20.h),
                          _buildLatestRelease(),
                          SizedBox(height: 20.h),
                          const PortfolioView(),
                          SizedBox(height: 20.h),
                          _buildAlbumHeader(controller),
                        ],
                      );
                    } else if (controller.selectedTab.value == "Experience") {
                      return Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: const ExperienceTabView(),
                      );
                    } else {
                      // Default for "Bio"
                      return Column(
                        children: [
                          SizedBox(height: 20.h),
                          _buildLatestRelease(),
                          SizedBox(height: 20.h),
                          _buildAboutSection(controller),
                          SizedBox(height: 20.h),
                          _buildAlbumHeader(controller),
                        ],
                      );
                    }
                  }),
                ),
              ),

              // 5. Reactive Album List (Grid or Horizontal)
              // FIXED: Hidden for both "Skills & Genres" AND "Experience"
              Obx(() {
                if (controller.selectedTab.value == "Skills & Genres" ||
                    controller.selectedTab.value == "Experience") {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }

                return controller.isAllAlbumsVisible.value
                    ? SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 230.h,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                          _buildAlbumCard(controller.albums[index]),
                      childCount: controller.albums.length,
                    ),
                  ),
                )
                    : SliverToBoxAdapter(
                  child: SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 20.w, bottom: 20.h),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.albums.length,
                      itemBuilder: (context, index) =>
                          _buildAlbumCard(controller.albums[index]),
                    ),
                  ),
                );
              }),

              SliverToBoxAdapter(child: SizedBox(height: 40.h)),
            ],
          ),
        ],
      ),
    );
  }

  // --- Utility Widgets ---

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
          Text("Available",
              style: TextStyle(color: Colors.white, fontSize: 12.sp)),
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
                  onPressed: () => Get.to(() => const EditProfileScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD458FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r)),
                  ),
                  child: Text("Edit Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              height: 48.h,
              width: 48.h,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle),
              child: const Icon(Icons.share, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: OutlinedButton(
            // onPressed: (){},
             onPressed: () => Get.to(() => const AddGigScreen()),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFD458FF)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r)),
            ),
            child: Text("Add Gig",
                style: TextStyle(color: Colors.white, fontSize: 16.sp)),
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection(SingerProfileController controller) {
    List<String> tabs = ["Bio", "Portfolio", "Skills & Genres", "Experience"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: tabs
            .map((tab) => Obx(() {
          bool isSelected = controller.selectedTab.value == tab;
          return GestureDetector(
            onTap: () => controller.changeTab(tab),
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.symmetric(
                  horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFD458FF).withOpacity(0.2)
                    : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(
                    color: isSelected
                        ? const Color(0xFFD458FF)
                        : Colors.transparent),
              ),
              child: Text(tab,
                  style: TextStyle(
                      color:
                      isSelected ? Colors.white : Colors.white38)),
            ),
          );
        }))
            .toList(),
      ),
    );
  }

  Widget _buildLatestRelease() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("LATEST RELEASE",
                    style: TextStyle(color: Colors.white38, fontSize: 10.sp)),
                SizedBox(height: 8.h),
                Text("Under Ocean Blvd",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold)),
                Text("Album • 2026",
                    style: TextStyle(color: Colors.white38, fontSize: 12.sp)),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset('assets/images/music cover_1.png',
                width: 70.w, height: 70.w, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(SingerProfileController controller) {
    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "About",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (!controller.isEditingAbout.value)
                IconButton(
                  onPressed: () => controller.isEditingAbout.value = true,
                  icon: Icon(
                    Icons.edit_note,
                    color: const Color(0xFFD458FF),
                    size: 24.sp,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          if (controller.isEditingAbout.value)
            Column(
              children: [
                TextField(
                  controller: controller.aboutEditController,
                  autofocus: true,
                  maxLines: null,
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: "Enter bio...",
                    hintStyle: const TextStyle(color: Colors.white24),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => controller.isEditingAbout.value = false,
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.white60)),
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton(
                      onPressed: () => controller.saveAbout(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD458FF),
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: const Text("Save",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            )
          else
            GestureDetector(
              onTap: controller.toggleAbout,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: controller.isAboutExpanded.value
                          ? controller.aboutText.value
                          : (controller.aboutText.value.length > 120
                          ? "${controller.aboutText.value.substring(0, 120)}..."
                          : controller.aboutText.value),
                    ),
                    if (controller.aboutText.value.length > 120)
                      TextSpan(
                        text: controller.isAboutExpanded.value
                            ? " show less"
                            : " see more",
                        style: const TextStyle(
                          color: Color(0xFFD458FF),
                          fontWeight: FontWeight.bold,
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

  Widget _buildAlbumHeader(SingerProfileController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Albums",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: controller.toggleSeeAllAlbums,
          child: Text(
              controller.isAllAlbumsVisible.value ? "Show less" : "See all",
              style: const TextStyle(color: Color(0xFFD458FF))),
        ),
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
            child: Image.asset(album['image']!,
                height: 160.h, width: 160.w, fit: BoxFit.cover),
          ),
          SizedBox(height: 8.h),
          Text(album['title']!,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1),
          Text(album['artist']!,
              style: TextStyle(color: Colors.white38, fontSize: 12.sp)),
        ],
      ),
    );
  }
}