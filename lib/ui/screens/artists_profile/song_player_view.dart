import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'song_player_controller.dart';

class SongPlayerView extends StatelessWidget {
  final List<Map<String, String>> playlist;
  final int initialIndex;
  late final PlayerController controller;

  SongPlayerView({super.key, required this.playlist, required this.initialIndex}) {
    // We use Get.put uniquely or find it if it already exists
    controller = Get.put(PlayerController(playlist: playlist, initialIndex: initialIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120C1C),
      body: Obx(() {
        final track = controller.currentTrack; 
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(track['image']!, fit: BoxFit.cover),
            ),
            // Re-adding the ShaderMask/Gradient fade to match Taylor Swift image
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF120C1C).withOpacity(0.8),
                      const Color(0xFF120C1C),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _buildTopBar(),
                  const Spacer(),
                  // Pass the track here
                  _buildSongDetails(track), 
                  // Call without arguments
                  _buildPlaybackControls(), 
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  // UPDATED: Now accepts the track parameter
  Widget _buildSongDetails(Map<String, String> track) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text(
                  track['title']!,
                  style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "(${track['genre']})",
                style: const TextStyle(color: Colors.white38, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            track['artist']!,
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              _circleIcon(Icons.favorite_border),
              const SizedBox(width: 15),
              _circleIcon(Icons.share_outlined),
            ],
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }

  Widget _buildPlaybackControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("2:53", style: TextStyle(color: Colors.white38, fontSize: 12)),
              Text("5:01", style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.shuffle, color: Colors.white54, size: 22),
              
              // Added functionality to the buttons via the controller
              GestureDetector(
                onTap: () => controller.previousSong(),
                child: _buildPlayerControl(Icons.skip_previous_rounded),
              ),

              _buildPlayerControl(Icons.play_arrow_rounded),

              GestureDetector(
                onTap: () => controller.nextSong(),
                child: _buildPlayerControl(Icons.skip_next_rounded),
              ),

              const Icon(Icons.repeat, color: Colors.white54, size: 22),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerControl(IconData icon) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 35),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white12),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
            onPressed: () => Get.back(),
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white, size: 24),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}