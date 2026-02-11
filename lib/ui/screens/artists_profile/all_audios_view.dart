import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/artists_profile/song_player_view.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'artists_model.dart';

class AllAudioView extends StatelessWidget {
  final Artist data;
  const AllAudioView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Wrap with AppBackground to maintain consistent UI glow
    return AppBackground(
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Required to see the AppBackground
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text(
            "All Audio",
            style: GoogleFonts.poltawskiNowy(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: data.audioTracks.length,
          itemBuilder: (context, index) {
            final track = data.audioTracks[index];
            return _buildFullAudioListItem(track, index);
          },
        ),
      ),
    );
  }

  Widget _buildFullAudioListItem(Map<String, String> track, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Better spacing
      child: InkWell(
        onTap: () => Get.to(
          () => SongPlayerView(
            playlist: data.audioTracks,
            initialIndex: index,
          ),
        ),
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            // 1. Thumbnail Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                track['image']!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60, height: 60, color: Colors.white10, 
                  child: const Icon(Icons.music_note, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 15),

            // 2. Title and Artist
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    track['artist']!,
                    style: const TextStyle(color: Colors.white38, fontSize: 14),
                  ),
                ],
              ),
            ),

            // 3. Play Button or Genre
            Text(
              "(${track['genre']})",
              style: const TextStyle(color: Colors.white24, fontSize: 12),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.more_vert, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
