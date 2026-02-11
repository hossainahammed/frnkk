import 'package:get/get.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final CardSwiperController swiperController = CardSwiperController();
  var searchQuery = ''.obs;

  // Update this list so it is NOT empty
  final List<Map<String, dynamic>> profiles = [
    {
      "name": "Ben Collins",
      "role": "Singer",
      "location": "Via S. Martino, Lisciano Niccone PG, Italy",
      "image":
          "assets/images/home_images/BenCollins.png", // Ensure this exists!
      "genres": ["Hip-hop", "Alternative", "Pop"],
    },
    {
      "name": "Sarah Jenkins",
      "role": "Guitarist",
      "location": "Rome, Italy",
      "image": "assets/images/home_images/TaylorSwift.png",
      "genres": ["Jazz", "Blues"],
    },
  ].obs;
  
  
  List<Map<String, dynamic>> get filteredProfiles {
    if (searchQuery.value.isEmpty) {
      return profiles;
    }
    return profiles.where((profile) {
      final name = profile['name'].toString().toLowerCase();
      final role = profile['role'].toString().toLowerCase();
      final query = searchQuery.value.toLowerCase();
      return name.contains(query) || role.contains(query);
    }).toList();
  }



  bool onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    final swipedProfile = profiles[previousIndex];

    if (direction == CardSwiperDirection.right) {
      // Logic for Liking
      debugPrint("Liked: ${swipedProfile['name']}");
      _handleLike(swipedProfile);
    } else if (direction == CardSwiperDirection.left) {
      // Logic for Disliking/Removing
      debugPrint("Removed/Passed: ${swipedProfile['name']}");
      _handleRemove(swipedProfile);
    }

    return true; // Return true to complete the swipe animation
  }

  void _handleLike(Map<String, dynamic> profile) {
    // Trigger the "Matched" popup or send a request to your database
    // Get.bottomSheet(MatchPopup(profile: profile));
  }

  void _handleRemove(Map<String, dynamic> profile) {
    // Logic to ignore this user or remove them from local suggestions
  }
}
