import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/explore/explore_view.dart';
import 'package:frnkk/ui/screens/home/main_swipe_page.dart';
import 'package:frnkk/ui/screens/match/match_request_view.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:frnkk/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:frnkk/widgets/bottom_navigation_bar/custom_bottom_nav.dart';
import 'package:frnkk/widgets/custom_drawer.dart';


class HomeScreen extends GetView<NavigationController> {
  const HomeScreen({super.key});
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomAppDrawer(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      // We use Obx here to listen to the NavigationController index
      body: AppBackground(
        child: Obx(() => IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            const MainSwipePage(), 
            const MatchRequestPage(),
            const ExplorePage(), 
            _buildPlaceholder("Message Page"), 
            _buildPlaceholder("Profile Page"), 
          ],
        )),
      ),
      bottomNavigationBar: const CustomBottomNav(),
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