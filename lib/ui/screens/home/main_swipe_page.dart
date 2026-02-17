import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/Subscription/SubscriptionScreen.dart';
import 'package:frnkk/ui/screens/home/home_controller.dart';
import 'package:frnkk/ui/screens/home/home_view.dart';
import 'package:frnkk/ui/screens/notifications/notifications_view.dart';
import 'package:get/get.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frnkk/widgets/custom_app_header.dart';
import 'package:frnkk/routes/app_routes.dart';

class MainSwipePage extends StatefulWidget {
  const MainSwipePage({super.key});

  @override
  State<MainSwipePage> createState() => _MainSwipePageState();
}

class _MainSwipePageState extends State<MainSwipePage> {
  final controller = Get.find<HomeController>();

  int _activeCardIndex = 0;

  void _showMatchStatus(bool isFullMatch) {
    Get.bottomSheet(
      isScrollControlled: true,
      isFullMatch ? _buildMatchedSheet() : _buildRequestSentSheet(),
      backgroundColor: Colors.transparent,
    );
  }

  void _showGhostPopup({required IconData icon, required Color color}) {
    Get.dialog(
      Center(
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1600),
          // Starts at 0.5 scale and grows to 1.2
          tween: Tween<double>(begin: 0.5, end: 0.7),
          curve: Curves.easeOutBack,
          builder: (context, double value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                // Fades out as it grows
                opacity: (1.2 - value).clamp(0.0, 0.6),
                child: child,
              ),
            );
          },
          child: Container(
            height: 120,
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 70),
          ),
        ),
      ),
      barrierColor: Colors.transparent, // Keeps the UI behind clear
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    });
  }

  void _showMatchRequestSheet(Map<String, dynamic> profile) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: const BoxDecoration(
          color: Color(0xFF0F0118), // Match the dark deep purple
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Match Request",
              style: TextStyle(
                color: Color(0xFFD455E9), // Specific purple from screenshot
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Rotated Images Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. LEFT IMAGE (Rotated Counter-Clockwise)
                Transform.rotate(
                  angle: -0.12, // Subtle tilt
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          profile['image'],
                          width: 130,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Floating Heart Bubble
                      Positioned(
                        top: -15,
                        left: -5,
                        child: _buildBubbleIcon(
                          Icons.favorite,
                          Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5), // Tight spacing due to rotation
                // 2. RIGHT IMAGE (Rotated Clockwise + Blurred)
                Transform.rotate(
                  angle: 0.12,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          profile['image'],
                          width: 130,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Blur Overlay
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                            child: Container(color: Colors.black26),
                          ),
                        ),
                      ),
                      // Question Mark Bubbles (Top and Right)
                      Positioned(
                        top: -10,
                        right: 10,
                        child: _buildBubbleIcon(
                          Icons.help_outline,
                          const Color(0xFFD455E9),
                          size: 18,
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        right: -15,
                        child: _buildBubbleIcon(
                          Icons.help_outline,
                          const Color(0xFFD455E9),
                          size: 24,
                        ),
                      ),
                      // Large Center Question Mark
                      _buildBubbleIcon(
                        Icons.help_outline,
                        const Color(0xFFD455E9),
                        size: 35,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Text Content
            const Text(
              "Request Sent Successfully 🎉",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Your message will be seen before matching — keep it friendly and respectful.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFD455E9),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD455E9),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.toNamed(AppRoutes.chat, arguments: profile);
                    },
                    child: const Text(
                      "Message",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Helper for the small floating icons in speech bubbles
  Widget _buildBubbleIcon(IconData icon, Color color, {double size = 20}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: size),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppHeader(
            leftWidget: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                // This is the "Something" that happens
                HomeScreen.scaffoldKey.currentState?.openDrawer();
              },
            ),
            centerWidget: Text(
              "Vibe matchR",
              style: GoogleFonts.poltawskiNowy(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            rightWidget: Row(
              mainAxisSize: MainAxisSize
                  .min, // Essential: prevents Row from taking full width
              children: [
                // In MainSwipePage.dart
                IconButton(
                  icon: const Icon(
                    Icons.workspace_premium,
                    color: Colors.white,
                  ),
                  onPressed: () => Get.to(
                    () => const SubscriptionScreen(),
                    arguments: {'fromMainSwipe': true}, // Pass the flag here
                  ),
                ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.workspace_premium,
                //     color: Colors.white,
                //   ),
                //   onPressed: ()=>Get.to(()=>const SubscriptionScreen()),
                // ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.to(() => NotificationPage(hasNotifications: false));
                  },
                ),
              ],
            ),
          ),

          Container(
            height: 45,
            width: 370,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              onChanged: (value) {
                controller.searchQuery.value = value; // Trigger the filter
                setState(
                  () => _activeCardIndex = 0,
                ); // Reset index to the first found card
              },
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: const InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.white38),
                prefixIcon: Icon(Icons.search, color: Colors.white38, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Obx(() {
                if (controller.profiles.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CardSwiper(
                  controller: controller.swiperController,
                  cardsCount: controller.profiles.length,
                  allowedSwipeDirection: const AllowedSwipeDirection.only(
                    left: true,
                    right: true,
                  ),
                  onSwipe: (previousIndex, currentIndex, direction) {
                    if (direction == CardSwiperDirection.right) {
                      _showGhostPopup(icon: Icons.favorite, color: Colors.red);
                    } else if (direction == CardSwiperDirection.left) {
                      _showGhostPopup(icon: Icons.close, color: Colors.red);
                    }

                    if (currentIndex != null) {
                      setState(() => _activeCardIndex = currentIndex);
                    }
                    return true;
                  },
                  onUndo: (previousIndex, currentIndex, direction) {
                    // IMPORTANT: This handles when a card is brought back!
                    setState(() {
                      _activeCardIndex = currentIndex;
                    });
                    return true;
                  },
                  numberOfCardsDisplayed: 2,
                  backCardOffset: const Offset(0, 0),
                  padding: EdgeInsets.zero,
                  cardBuilder:
                      (context, index, horizontalThreshold, verticalThreshold) {
                        final profile = controller.profiles[index];
                        bool isBackground = index != _activeCardIndex;
                        return _buildSwipableCard(
                          profile,
                          isBlurred: isBackground,
                        );
                      },
                );
              }),
            ),
          ),
          _buildActionButtons(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSwipableCard(
    Map<String, dynamic> profile, {
    required bool isBlurred,
  }) {
    return Stack(
      children: [
        _buildProfileCard(profile),

        // This only shows on the card sitting behind the current one
        if (isBlurred)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.black.withOpacity(0.15)),
              ),
            ),
          ),
      ],
    );
  }

  // --- UI Components ---

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            iconSize: 32,
            onPressed: () {
              // This looks for the HomeScreen's Scaffold and opens its drawer
              HomeScreen.scaffoldKey.currentState?.openDrawer();
            },
          ),
          Text(
            "Vibe matchR",
            style: GoogleFonts.nunitoSans(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Row(
            children: [
              Icon(Icons.workspace_premium, color: Colors.white),
              SizedBox(width: 15),
              Icon(Icons.notifications_none, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> profile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: AssetImage(profile['image']),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Align the gradient container to the absolute bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              // Padding: 40 top (to give the gradient room to fade), 20 others
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              decoration: BoxDecoration(
                // Match the card's bottom rounding
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
                // Gradient starts transparent and darkens behind the text
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    //  Colors.transparent,
                    const Color.fromARGB(
                      255,
                      8,
                      3,
                      34,
                    ).withOpacity(0.7), // Mid-transition
                    const Color.fromARGB(
                      255,
                      210,
                      82,
                      222,
                    ).withOpacity(0.7), // Solid bottom
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Wrap only the text height
                children: [
                  Text(
                    profile['name'],
                    style: GoogleFonts.poltawskiNowy(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  _infoRow(Icons.work_outline, profile['role']),
                  const SizedBox(height: 5),
                  _infoRow(Icons.location_on_outlined, profile['location']),
                  const SizedBox(height: 10),
                  Row(
                    children: profile['genres']
                        .map<Widget>((g) => _genreChip(g))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.nunitoSans(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _actionCircle(Icons.close, Colors.red, () {
          controller.swiperController.swipe(CardSwiperDirection.left);
        }),
        _actionCircle(Icons.favorite, Colors.red, () {
          // 1. Get the profile currently being displayed
          final currentProfile = controller.profiles[_activeCardIndex];
          _showMatchRequestSheet(currentProfile);
        }),
        _actionCircle(Icons.near_me, Colors.blue, () {
          if (controller.profiles.isNotEmpty &&
              _activeCardIndex < controller.profiles.length) {
            final currentProfile = controller.profiles[_activeCardIndex];
            Get.toNamed(AppRoutes.chat, arguments: currentProfile);
          }
        }),
      ],
    );
  }

  Widget _actionCircle(
    IconData icon,
    Color color,
    VoidCallback onTap, {
    bool isLarge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isLarge ? 75 : 60,
        width: isLarge ? 75 : 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: isLarge ? 40 : 30),
      ),
    );
  }

  Widget _genreChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.purple.withOpacity(0.8)],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchedSheet() => Container(
    height: 500,
    color: Colors.purple,
    child: const Center(child: Text("Matched!")),
  );
  Widget _buildRequestSentSheet() => Container(
    height: 500,
    color: Colors.blue,
    child: const Center(child: Text("Request Sent")),
  );
}
