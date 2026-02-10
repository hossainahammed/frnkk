import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/artists_profile/all_audios_view.dart';
import 'package:frnkk/ui/screens/artists_profile/artists_profile_controller.dart';
import 'package:frnkk/ui/screens/artists_profile/song_player_view.dart';
import 'package:get/get.dart';
import 'artists_model.dart';

class PortfolioTabView extends StatelessWidget {
  final Artist data;
  final Widget albumSection;

  const PortfolioTabView({
    super.key,
    required this.data,
    required this.albumSection,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ArtistProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Audio Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "All Audio",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // REMOVED Obx here because the "More" button is static
            TextButton(
              onPressed: () => Get.to(() => AllAudioView(data: data)),
              child: Text(
                "More",
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
            ),
          ],
        ),

        // Audio List Section
        Obx(() {
          final int totalTracks = data.audioTracks.length;
          // Logic to show only top 3 unless expanded
          final int displayCount = controller.isAudioExpanded.value
              ? totalTracks
              : (totalTracks > 3 ? 3 : totalTracks);

          return AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayCount,
              itemBuilder: (context, index) {
                final track = data.audioTracks[index];
                // Pass the index as a second argument
                return _buildAudioListItem(track, index);
              },
            ),
          );
        }),

        albumSection,
      ],
    );
  }

  Widget _buildAudioListItem(Map<String, String> track, int index) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Get.to(() => SongPlayerView(
          playlist: data.audioTracks, 
          initialIndex: index,
        ));
      },
      child: Row(
        children: [
          // 1. Song Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              track['image']!, 
              width: 50, 
              height: 50, 
              fit: BoxFit.cover
            ),
          ),
          const SizedBox(width: 15),

          // 2. Song Title & Artist
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track['title']!, 
                  style: const TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 16
                  )
                ),
                const SizedBox(height: 4),
                Text(
                  track['artist']!, 
                  style: const TextStyle(color: Colors.white38, fontSize: 14)
                ),
              ],
            ),
          ),

          // 3. Play Button (Unified Style from "Song Play.jpg")
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded, 
              color: Colors.white, 
              size: 20
            ),
          ),
        ],
      ),
    ),
  );
}
}
