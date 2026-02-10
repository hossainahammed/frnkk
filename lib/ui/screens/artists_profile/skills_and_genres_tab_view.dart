import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'artists_model.dart';
import 'song_player_controller.dart';


class ArtistSkillsAndGenresTabView extends StatelessWidget {
  final Artist data;
  const ArtistSkillsAndGenresTabView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Language"),
        const SizedBox(height: 15),
        // Language Progress Bars
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: data.languages.map((lang) => _buildLanguageProgress(lang['name'], lang['value'])).toList(),
        ),
        

        const SizedBox(height: 30),
        _buildSectionTitle("Skills"),
        const SizedBox(height: 15),
        _buildTagWrap(data.skills),

        const SizedBox(height: 30),
        _buildSectionTitle("Genres"),
        const SizedBox(height: 15),
        _buildTagWrap(data.genres),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold));
  }

  // Linear progress indicator for languages
  Widget _buildLanguageProgress(String name, double value) {
    return SizedBox(
      width: Get.width * 0.4, // Two items per row
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(color: Colors.white, fontSize: 14)),
              Text("${(value * 100).toInt()}%", style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: value,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(10),
            minHeight: 4,
          ),
        ],
      ),
    );
  }

  // Tag clouds for Skills and Genres
  Widget _buildTagWrap(List<String> items) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items.map((item) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Text(item, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      )).toList(),
    );
  }
}