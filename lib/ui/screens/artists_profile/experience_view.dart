import 'package:flutter/material.dart';

import 'artists_model.dart';


class ExperienceView extends StatelessWidget {
  final Artist artist;
  const ExperienceView({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    // --- ALIGNMENT CONSTANTS ---
    const double yearColumnWidth = 65.0; // Fixed width for year text
    const double gapWidth = 10.0;        // Space between year and dot
    const double dotSize = 10.0;         // Diameter of the timeline dot
    
    // Calculated center point for the vertical line:
    // Year Width + Gap + half of the dot
    const double lineCenterPosition = yearColumnWidth + gapWidth + (dotSize / 2);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Stack(
          children: [
            // 1. THE VERTICAL LINE
            Positioned(
              left: lineCenterPosition - 0.75, // Subtract half of line thickness (1.5/2)
              top: 90,
              bottom: 30,
              child: Container(
                width: 1.5,
                color: const Color(0xFFD455E9).withOpacity(0.3),
              ),
            ),

            // 2. THE CONTENT COLUMN
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildJourneyHeader(artist.professionalJourney),
                const SizedBox(height: 15),

                ...artist.experiences.map((exp) => _buildTimelineItem(
                      yearAnchor: yearColumnWidth,
                      gap: gapWidth,
                      dotSize: dotSize,
                      yearTop: exp['yearTop'] ?? "",
                      yearBottom: exp['yearBottom'] ?? "",
                      role: exp['role']!,
                      project: exp['project']!,
                      period: exp['period']!,
                      description: exp['description']!,
                    )),

                _buildStatusSection(
                  artist.experienceStatus, 
                  yearAnchor: yearColumnWidth, 
                  gap: gapWidth, 
                  dotSize: dotSize
                ),
                const SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required double yearAnchor,
    required double gap,
    required double dotSize,
    required String yearTop,
    required String yearBottom,
    required String role,
    required String project,
    required String period,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // YEAR COLUMN (Centered as requested)
        SizedBox(
          width: yearAnchor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                "$yearTop\n$yearBottom",
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.visible, // Ensures 't' in Present is visible
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: gap),

        // DOT (Perfectly centered on the line)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            height: dotSize,
            width: dotSize,
            decoration: BoxDecoration(
              color: const Color(0xFF1A0B2E),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFD455E9), width: 2),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // CONTENT CARD
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              Text(project, style: const TextStyle(color: Colors.white54, fontSize: 11)),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(period, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    const Divider(color: Colors.white10, height: 16),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyHeader(Map<String, String> data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0B2E),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFD455E9).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Professional Journey as a Singer",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.mic, color: Colors.redAccent, size: 14),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    "${data['role']}  |  ${data['years']}",
                    style: const TextStyle(color: Colors.white70, fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection(
    List<Map<String, String>> statusList, {
    required double yearAnchor,
    required double gap,
    required double dotSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: yearAnchor + gap),
            Container(
              height: dotSize,
              width: dotSize,
              decoration: BoxDecoration(
                color: const Color(0xFF1A0B2E),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD455E9), width: 2),
              ),
            ),
            const SizedBox(width: 12),
            const Text("Experience Status", 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
       const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: yearAnchor + gap + dotSize + 12),
          child: Row(
            children: statusList.take(2).map((status) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${status['count']} ", 
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(status['label'] ?? "", 
                        style: const TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}