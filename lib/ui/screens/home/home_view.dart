import 'package:flutter/material.dart';
import 'package:frnkk/controllers/profile_controller.dart';
import 'package:frnkk/ui/screens/Settings/profileScreen.dart';
import 'package:frnkk/ui/screens/explore/explore_view.dart';
import 'package:frnkk/controllers/home_controller.dart';
import 'package:frnkk/ui/screens/home/main_swipe_page.dart';
import 'package:frnkk/ui/screens/match/match_request_view.dart';
import 'package:frnkk/ui/screens/messasge/message_list_view.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:frnkk/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:frnkk/widgets/bottom_navigation_bar/custom_bottom_nav.dart';
import 'package:frnkk/widgets/custom_drawer.dart';

class HomeScreen extends GetView<NavigationController> {
  const HomeScreen({super.key});
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(ProfileController());
    return PopScope(
      canPop: false, // Prevents exiting the app directly
      onPopInvoked: (didPop) {
        if (didPop) return;

        // If user is on any tab other than Home (0), go back to Home
        if (controller.selectedIndex.value != 0) {
          controller.changeTabIndex(0);
        } else {
          // If they are already on Home, you could show an exit dialog
          // or allow the pop
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: const CustomAppDrawer(),
        extendBodyBehindAppBar: true,
        extendBody: true,
        // We use Obx here to listen to the NavigationController index
        body: AppBackground(
          child: Obx(
            () => IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                const MainSwipePage(), // Index 0
                const MatchRequestPage(), // Index 1
                const ExplorePage(),
                const MessageListScreen(), // Index 2
                // _buildPlaceholder("Message Page"), // Index 3
                const ProfileScreen(), // Index 4
                // REMOVED the SizedBox.shrink() from here
              ],
            ),
          ),
        ),
        // body: AppBackground(
        //   child: Obx(() => IndexedStack(
        //     index: controller.selectedIndex.value,
        //     children: [
        //       const MainSwipePage(),
        //       const MatchRequestPage(),
        //       const ExplorePage(),
        //       _buildPlaceholder("Message Page"),
        //       const ProfileScreen(), // Replace the placeholder with the actual screen
        //       const SizedBox.shrink(),
        //     ],
        //   )),
        // ),
        // body: AppBackground(
        //   child: Obx(() => IndexedStack(
        //     index: controller.selectedIndex.value,
        //     children: [
        //       const MainSwipePage(),
        //       const MatchRequestPage(),
        //       const ExplorePage(),
        //       _buildPlaceholder("Message Page"),
        //       _buildPlaceholder("Profile Page"),
        //     ],
        //   )),
        // ),
        // bottomNavigationBar: const CustomBottomNav(),
        // home_view.dart
        bottomNavigationBar: Obx(() {
          // If index is 4 (Profile), return an empty box. Otherwise, show the Nav.
          return controller.selectedIndex.value == 4
              ? const SizedBox.shrink()
              : const CustomBottomNav();
        }),
      ),
    );
  }

  // Temporary helper to show tabs are working
  Widget _buildPlaceholder(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
