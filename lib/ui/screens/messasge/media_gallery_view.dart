import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:frnkk/widgets/buttons/custom_button.dart';

class MediaGalleryScreen extends StatelessWidget {
  MediaGalleryScreen({super.key});

  final RxInt selectedTabIndex = 0.obs;
  final List<String> tabs = ["Picture", "Video", "Files", "Links"];

  // --- ADD THESE VARIABLES TO FIX THE ERRORS ---
  final int imageCount = 0; // Set to > 0 to see the grid
  final int videoCount = 0;
  final int fileCount = 0;
  final int linkCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                    const Text(
                      "View Media, Files & Links",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              _buildCustomTabSelector(),

              Expanded(
                child: Obx(() {
                  switch (selectedTabIndex.value) {
                    case 0:
                      return imageCount == 0
                          ? _buildEmptyState(
                              title: "Picture Empty!",
                              subtitle:
                                  "Picture you exchange in this conversation will show up here.",
                              iconWidget: Image.asset(
                                'assets/images/message_icons/picture_empty.png', // Ensure path is correct
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            )
                          : _buildPictureGrid();
                    case 1:
                      return videoCount == 0
                          ? _buildEmptyState(
                              title: "Video Empty!",
                              subtitle:
                                  "Video you exchange in this conversation will show up here.",
                              iconWidget: Image.asset(
                                'assets/images/message_icons/video_empty.png', // Ensure path is correct
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            )
                          : _buildVideoGrid();
                    case 2: // Files Tab
                      return fileCount == 0 
                        ? _buildEmptyState(
                            title: "Files Empty!",
                            subtitle: "Files you exchange in this conversation will show up here.",
                            iconWidget: Image.asset('assets/images/message_icons/file_empty.png'),
                          )
                        : _buildFilesList();
                    case 3:
                      return _buildEmptyState(
                        title: "Links Empty!",
                        subtitle:
                            "Links you exchange in this conversation will show up here.",
                        iconWidget: const Icon(
                          Icons.link_outlined,
                          size: 60,
                          color: Colors.white,
                        ),
                      );
                    default:
                      return const SizedBox();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTabSelector() {
    return SizedBox(
      height: 45,
      width: Get.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: tabs.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Obx(() {
            final tab = tabs[index];
            bool isActive = selectedTabIndex.value == index;

            return SizedBox(
              width: 100,
              child: CustomButton(
                label: tab,
                height: 40,
                fontSize: 13,
                onPressed: () => selectedTabIndex.value = index,
                borderColor: isActive
                    ? const Color(0xFFD455E9)
                    : Colors.white.withOpacity(0.1),
                color: isActive
                    ? Colors.white.withOpacity(0.15)
                    : Colors.transparent,
                isGlassy: !isActive,
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildPictureGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: imageCount,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(color: Colors.white10), // Placeholder for images
        );
      },
    );
  }

  // --- ADDED THIS TO FIX THE MISSING METHOD ERROR ---
  Widget _buildVideoGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: videoCount,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(color: Colors.white10),
            ),
            const Center(
              child: Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState({
    required String title,
    required String subtitle,
    required Widget iconWidget,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers vertically in the Expanded area
          children: [
            // No more purple Container here, just the image
            SizedBox(
              height: 160, 
              width: 160,
              child: iconWidget,
            ),
            const SizedBox(height: 25),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w600,
                fontFamily: 'Serif', // <--- Apply your Serif font here
              ),
            ),
            const SizedBox(height: 15),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilesList() {
    // Dummy data to match your screenshot
    final List<Map<String, String>> files = [
      {"name": "A Rush of Blood to the Head", "desc": "Coldplay"},
      {"name": "Future Nostalgia", "desc": "Dua Lipa"},
      {"name": "Certified Lover Boy", "desc": "Drake"},
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: files.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.white.withOpacity(0.2), 
        height: 32,
      ),
      itemBuilder: (context, index) {
        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 55,
                height: 55,
                color: Colors.white10, // Placeholder for album/file art
                child: const Icon(Icons.insert_drive_file, color: Colors.white38),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    files[index]['name']!,
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    files[index]['desc']!,
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

}
