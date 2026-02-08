import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/Settings/profileScreen.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/bottom_navigation_bar/navigation_controller.dart';


class CustomBottomNav extends GetView<NavigationController> {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Theme(
        data: Theme.of(context).copyWith(
          // This removes the background color forced by the Theme
          canvasColor: Colors.transparent,
          // This removes the grey shadow/line often seen at the top
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          // UPDATED: Custom onTap to handle profile navigation
          onTap: (index) {
            if (index == 4) {
              // Profile icon tapped (index 4) - Navigate to ProfileScreen
              Get.to(() => const ProfileScreen());
            } else if (index == 3) {
              // For other tabs, use the controller's changeTabIndex
              //Get.to(() => const ProfileScreen());
              controller.changeTabIndex(index);
            }
            else if (index == 2) {
              //Get.to(() => const ProfileScreen());
              controller.changeTabIndex(index);

          }else {
              // For other tabs, use the controller's changeTabIndex
              controller.changeTabIndex(index);
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent, // Set to transparent
          elevation: 0, // Removes the shadow
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          selectedLabelStyle: _getGlowTextStyle(true),
          unselectedLabelStyle: _getGlowTextStyle(false),
          items: [
            _buildNavItem('home', 'Home', 0),
            _buildNavItem('match', 'Match', 1),
            _buildNavItem('explore', 'Explore', 2),
            _buildNavItem('message', 'Message', 3),
            _buildNavItem('profile', 'Profile', 4),
          ],
        ),
      ),
    );
  }

  TextStyle _getGlowTextStyle(bool isSelected) {
    return TextStyle(
      fontSize: 12,
      color: isSelected ? Colors.white : Colors.white38,
      shadows: [
        if (isSelected)
          const Shadow(
            color: Colors.white,
            blurRadius: 10.0,
          ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconName, String label, int index) {
    bool isSelected = controller.selectedIndex.value == index;

    return BottomNavigationBarItem(
      icon: _getIconImage(iconName, false),
      activeIcon: Stack(
        alignment: Alignment.center,
        children: [
          // The Neon Glow Layer
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: _getIconImage(iconName, true),
          ),
          // The Sharp Icon
          _getIconImage(iconName, true),
        ],
      ),
      label: label,
    );
  }

  Widget _getIconImage(String iconName, bool isSelected) {
    return Image.asset(
      'assets/images/navbar_icons/$iconName.png',
      width: 24,
      height: 24,
      color: isSelected ? Colors.white : Colors.white38,
    );
  }
}



// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:frnkk/widgets/bottom_navigation_bar/navigation_controller.dart';
//
// class CustomBottomNav extends GetView<NavigationController> {
//   const CustomBottomNav({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Theme(
//         data: Theme.of(context).copyWith(
//           // This removes the background color forced by the Theme
//           canvasColor: Colors.transparent,
//           // This removes the grey shadow/line often seen at the top
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//         ),
//         child: BottomNavigationBar(
//           currentIndex: controller.selectedIndex.value,
//           onTap: controller.changeTabIndex,
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.transparent, // Set to transparent
//           elevation: 0, // Removes the shadow
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.white38,
//           selectedLabelStyle: _getGlowTextStyle(true),
//           unselectedLabelStyle: _getGlowTextStyle(false),
//           items: [
//             _buildNavItem('home', 'Home', 0),
//             _buildNavItem('match', 'Match', 1),
//             _buildNavItem('explore', 'Explore', 2),
//             _buildNavItem('message', 'Message', 3),
//             _buildNavItem('profile', 'Profile', 4),
//           ],
//         ),
//       ),
//     );
//   }
//
//   TextStyle _getGlowTextStyle(bool isSelected) {
//     return TextStyle(
//       fontSize: 12,
//       color: isSelected ? Colors.white : Colors.white38,
//       shadows: [
//         if (isSelected)
//           const Shadow(
//             color: Colors.white,
//             blurRadius: 10.0,
//           ),
//       ],
//     );
//   }
//
//   BottomNavigationBarItem _buildNavItem(String iconName, String label, int index) {
//     bool isSelected = controller.selectedIndex.value == index;
//
//     return BottomNavigationBarItem(
//       icon: _getIconImage(iconName, false),
//       activeIcon: Stack(
//         alignment: Alignment.center,
//         children: [
//           // The Neon Glow Layer
//           ImageFiltered(
//             imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//             child: _getIconImage(iconName, true),
//           ),
//           // The Sharp Icon
//           _getIconImage(iconName, true),
//         ],
//       ),
//       label: label,
//     );
//   }
//
//   Widget _getIconImage(String iconName, bool isSelected) {
//     return Image.asset(
//       'assets/images/navbar_icons/$iconName.png',
//       width: 24,
//       height: 24,
//       color: isSelected ? Colors.white : Colors.white38,
//     );
//   }
// }