import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frnkk/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchRequestPage extends StatelessWidget {
  const MatchRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      // Using your custom background widget
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors
              .transparent, // Make scaffold transparent to see AppBackground
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              // onPressed: () => Navigator.pop(context),
              // onPressed: () => Get.to(HomeScreen()),
              onPressed: () {
                // Switch back to the home tab (index 0) instead of navigating
                final navController = Get.find<NavigationController>();
                navController.changeTabIndex(
                  0,
                ); // Assumes changeTabIndex is the method in NavigationController
              },
            ),
            title: Text(
              "Match",
              style: GoogleFonts.poltawskiNowy(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: const TabBar(
              indicatorColor: Color(0xFFD35D6E), // Coral line from your image
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.purpleAccent,
              unselectedLabelColor: Colors.white60,
              tabs: [
                Tab(text: "Request"),
                Tab(text: "Sent Request"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              MatchList(isSentRequest: false),
              MatchList(isSentRequest: true),
            ],
          ),
        ),
      ),
    );
  }
}

class MatchList extends StatelessWidget {
  final bool isSentRequest;
  const MatchList({super.key, required this.isSentRequest});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: 8, // Replace with your controller logic
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return _MatchTile(
          onTap: () {
            // Add navigation or action here if needed
          },
        );
      },
    );
  }
}

class _MatchTile extends StatefulWidget {
  final VoidCallback onTap;
  const _MatchTile({required this.onTap});

  @override
  State<_MatchTile> createState() => _MatchTileState();
}

class _MatchTileState extends State<_MatchTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        widget.onTap();
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) setState(() => _isPressed = false);
        });
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: _isPressed
              ? const Color.fromARGB(255, 210, 82, 222)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          minTileHeight: 63,
          leading: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    'assets/images/artists_profile_images/selena.png',
                  ),
                ),
              ),
              Positioned(
                right: 2,
                top: 1,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          title: const Text(
            "Salena Gomez",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Last Activity",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                "12 Aug 2022 - 12:55 am",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
