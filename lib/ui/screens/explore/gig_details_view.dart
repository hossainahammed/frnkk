import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/Settings/contact_us_screenn.dart';
import 'package:frnkk/ui/screens/artists_profile/artists_model.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:frnkk/widgets/buttons/custom_button.dart';


class GigDetailsView extends StatelessWidget {
  final Map<String, dynamic> data;
  const GigDetailsView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Stack(
          children: [
            // 1. THE MASK: This makes the text disappear at the bottom
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black, // Top is fully visible
                    Colors.black, // Middle is fully visible
                    Colors.transparent, // Bottom fades to transparent
                  ],
                  stops: [0.0, .8, 1.0], // Fade starts at 85% of the height
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn, // Key for transparency masking
              child: CustomScrollView(
                slivers: [
                  _buildAppBar(),
                  _buildContentBody(),
                  // Spacer so you can actually scroll the last text into the fade zone
                  const SliverToBoxAdapter(child: SizedBox(height: 150)),
                ],
              ),
            ),

            // 2. THE BUTTON: Remains solid and sits on top of the fade
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: CustomButton(
                label: "Message",
                onPressed: () =>Get.to(() => const ContactUsScreen()),
                // onPressed: () => print("Contacting ${data['name']}..."),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Keep your existing Helper Widgets (_buildAppBar, _buildContentBody, etc.) ---

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(data['image'], fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildContentBody() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainInfo(),
            const Divider(color: Colors.white24, height: 30),
            _buildSectionTitle("Event Type"),
            _buildEventTypeGrid(),
            const SizedBox(height: 20),
            _buildSectionTitle("Included"),
            _buildDescriptionText(),
            const SizedBox(height: 20),
            _buildSectionTitle("Excluded"),
            _buildDescriptionText(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainInfo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['role'],
            style: const TextStyle(
              color: Colors.purpleAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              // We find the matching Artist object from your Mock Data
              // This ensures we pass a real "Artist" object, not just a Map
              final artistObject = ArtistMockData.artists.firstWhere(
                (a) => a.name == data['name'],
                orElse: () => ArtistMockData.artists[0],
              );

              Get.toNamed('/artist-profile', arguments: artistObject);
            },
            child: Text(
              data['name'], // Use the name from the 'data' map provided to this view
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Text(
            data['location'],
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    ],
  );
}

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDescriptionText() {
    return const Text(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      style: TextStyle(color: Colors.white70, height: 1.5),
    );
  }

  Widget _buildEventTypeGrid() {
    final types = ["Party", "Wading", "Corporate", "Music Festival"];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: types
          .map(
            (type) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.radio_button_off,
                  color: Colors.white54,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  "$type 500\$/Hr",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
