import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/artists_profile/artists_profile_controller.dart';
import 'package:frnkk/ui/screens/artists_profile/experience_view.dart';
import 'package:frnkk/ui/screens/artists_profile/portfolio_tab_view.dart';
import 'package:frnkk/ui/screens/artists_profile/skills_and_genres_tab_view.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:frnkk/widgets/buttons/custom_button.dart';

import 'artists_model.dart';
// import 'package:frnkk/app/module/artists_profile/artists_profile_controller.dart';
// import 'package:frnkk/app/module/artists_profile/artists_model.dart';
// import 'package:frnkk/app/module/artists_profile/portfolio_tab_view.dart';
// import 'package:frnkk/app/module/artists_profile/skills_and_genres_tab_view.dart';
// import 'package:frnkk/app/module/artists_profile/experience_view.dart';


class ArtistProfileView extends StatelessWidget {
  const ArtistProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Initialize the controller
    final controller = Get.put(ArtistProfileController());

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header Image and Name Section
            Obx(() {
              final data = controller.artistData.value;
              if (data == null)
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              return _buildSliverHeader(data);
            }),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildMainActionButtons(),
                    const SizedBox(height: 25),

                    // The Tab Bar (Bio, Portfolio, etc.)
                    _buildCategoryTabs(),
                    const SizedBox(height: 25),

                    // --- THE GETX SWITCHBOARD (This swaps your content) ---
                    Obx(() {
                      final data = controller.artistData.value!;

                      // We look at the 'selectedTab' value in the controller
                      switch (controller.selectedTab.value) {
                        case "Portfolio":
                          // When "Portfolio" is selected, show the new View
                          return PortfolioTabView(
                            data: data,
                            albumSection: _buildAlbumSection(data),
                          );
                        case "Skills & Genres":
                          return ArtistSkillsAndGenresTabView(data: data);
                        case "Experience":
                          return ExperienceView(artist: data);
                        case "Bio":
                        default:
                          // By default, show the Bio (Latest Release + About)
                          return _buildBioContent(data);
                      }
                    }),

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverHeader(Artist data) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor:
          Colors.transparent, // Transparent to show background glow
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => Get.back(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(data.image, fit: BoxFit.cover),
            // Gradient overlay to fade image into the background
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black26, // Subtle darkening for the name
                    Colors.transparent, // Fades out so AppBackground takes over
                  ],
                  stops: [0.5, 0.8, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        data.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildAvailableBadge(),
                    ],
                  ),
                  Text(
                    "${data.connections} Connections",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD252DE)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 3, backgroundColor: Colors.orange),
          SizedBox(width: 5),
          Text(
            "Available",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildMainActionButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            label: "Match",
            height: 36,
            onPressed: () {},
            color: const Color(0xFFD455E9),
            borderColor: Colors.white.withOpacity(0.5),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: CustomButton(
            label: "Message",
            height: 36,
            onPressed: () {},
            isGlassy: true,
            borderColor: Colors.white.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    final controller = Get.find<ArtistProfileController>();
    final List<String> tabs = [
      "Bio",
      "Portfolio",
      "Skills & Genres",
      "Experience",
    ];

    return SizedBox(
      height: 36,
      // By not wrapping this in a Padding widget, the ListView can touch the screen edges
      width: Get.width,
      child: Obx(() {
        final currentTab = controller.selectedTab.value;

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          // IMPORTANT: This internal padding aligns the first item with your "Match" button
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: tabs.length,
          clipBehavior:
              Clip.none, // Allows shadows/glows to bleed out slightly if needed
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final tab = tabs[index];
            bool isActive = currentTab == tab;

            return IntrinsicWidth(
              child: CustomButton(
                label: tab,
                height: 40,
                fontSize: 15, // Large, readable font as requested
                onPressed: () => controller.changeTab(tab),
                borderColor: isActive
                    ? const Color(0xFFD455E9)
                    : Colors.white.withOpacity(0.1),
                color: isActive
                    ? Colors.white.withOpacity(0.15)
                    : Colors.transparent,
                isGlassy: !isActive,
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildLatestReleaseCard(Artist data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "LATEST RELEASE",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data.albums.isNotEmpty
                          ? data.albums[0]['title']!
                          : "No Release",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Album • 2026",
                      style: TextStyle(color: Colors.white38, fontSize: 14),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  data.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBioContent(Artist data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLatestReleaseCard(data),
        const SizedBox(height: 30),
        _buildAboutSection(data),
        const SizedBox(height: 30),
        _buildAlbumSection(data),
      ],
    );
  }

  Widget _buildPortfolioContent(Artist data) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6, // Mock count
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(data.image, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildSkillsContent(Artist data) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Text(
          "Skills & Genres Content Goes Here",
          style: TextStyle(color: Colors.white60, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildExperienceContent(Artist data) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Text(
          "Experience & Timeline Content Goes Here",
          style: TextStyle(color: Colors.white60, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildAboutSection(Artist data) {
    final controller = Get.find<ArtistProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "About",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          // Accessing .value here ensures the Obx has a stream to listen to
          final isExpanded = controller.isAboutExpanded.value;
          final String bioText = data.bio;

          final String displayedText = (isExpanded || bioText.length < 150)
              ? bioText
              : "${bioText.substring(0, 150)}";

          return GestureDetector(
            onTap: () => controller.toggleAboutExpanded(),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: displayedText,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                  TextSpan(
                    text: isExpanded ? " see less" : " ...see more",
                    style: const TextStyle(
                      color: Color(0xFFD455E9),
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => controller.toggleAboutExpanded(),
                  ),
                ],
              ),
              // ADD THIS LINE FOR JUSTIFIED ALIGNMENT
              textAlign: TextAlign.justify,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAlbumSection(Artist data) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Albums",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "See all",
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 220, // Adjusted height
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.albums.length,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              final album = data.albums[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- THE VINYL STACK ---
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        // 1. The Grey Sleeve Background
                        Container(
                          height: 140,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        // 2. The Vinyl Record (Poking out)
                        Positioned(
                          right: 8,
                          child: SizedBox(
                            height: 125,
                            width: 125,
                            child: ClipOval(
                              // Ensures the image stays perfectly circular
                              child: Image.asset(
                                'assets/images/album_images/disc.png', // <-- REPLACE with your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        // 3. The Album Cover
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              album['image']!,
                              height: 125,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // 4. Checkmark Badge
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.white54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 10,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // --- TEXT LABELS ---
                    Text(
                      album['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Salena Gomez", // Matching your screenshot text
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
