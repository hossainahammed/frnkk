import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/home/home_view.dart';
import 'package:frnkk/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';

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
                navController.changeTabIndex(0);  // Assumes changeTabIndex is the method in NavigationController
              },

            ),
            title: const Text(
              "Match",
              style: TextStyle(
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
      padding: const EdgeInsets.all(20),
      itemCount: 8, // Replace with your controller logic
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return Row(
          children: [
            // Profile Image with Online Dot
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      'assets/images/artists_profile_images/selena.png',
                    ), // Add your image
                  ),
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent, // Blue dot from image
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),

            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Salena Gomez",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last Activity",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "12 Aug 2022 - 12:55 am",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Date/Time
          ],
        );
      },
    );
  }
}
