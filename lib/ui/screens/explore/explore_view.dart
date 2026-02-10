import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/explore/explore_controller.dart';
import 'package:frnkk/ui/screens/explore/gig_details_view.dart';
import 'package:frnkk/ui/screens/home/home_view.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/custom_app_header.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExploreController());
    return SafeArea(
      child: Column(
        children: [
          CustomAppHeader(
            // 1. LEFT ICON: Open the Drawer
            leftWidget: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                HomeScreen.scaffoldKey.currentState?.openDrawer();
              },
            ),

            // 2. CENTER WIDGET: The Search Bar
            centerWidget: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                onChanged: (value) => controller.searchQuery.value = value,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: "Search Genre",
                  hintStyle: TextStyle(color: Colors.white38),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white38,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),

            // 3. RIGHT ICONS: Premium and Notifications
            rightWidget: Row(
              mainAxisSize: MainAxisSize.min, // Prevents row from expanding
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.workspace_premium, color: Colors.white, size: 22),
                  onPressed: () => print("Premium tapped"),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.notifications_none, color: Colors.white, size: 22),
                  onPressed: () => print("Notifications tapped"),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              final displayItems = controller.filteredItems;

              if (displayItems.isEmpty) {
                return const Center(
                  child: Text(
                    "No items found",
                    style: TextStyle(color: Colors.white54),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                itemCount: displayItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                
                itemBuilder: (context, index) {
                  final itemData = displayItems[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => GigDetailsView(data: itemData));
                    },
                    child: _buildExploreCard(displayItems[index]),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreCard(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              data['image'],
              width: 124,
              height: 102,
              fit: BoxFit.cover,
              // Error handling if image path is wrong
              errorBuilder: (context, error, stackTrace) => Container(
                width: 124,
                height: 102,
                color: Colors.white10,
                child: const Icon(Icons.broken_image, color: Colors.white38),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['role'],
                      style: const TextStyle(
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(
                      Icons.more_vert,
                      color: Colors.white54,
                      size: 20,
                    ),
                  ],
                ),
                Text(
                  data['name'],
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  data['location'],
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['genres'],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      data['price'],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
