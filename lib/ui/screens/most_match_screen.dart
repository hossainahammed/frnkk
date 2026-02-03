import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/common_widgets.dart';

class MostMatchScreen extends StatefulWidget {
  const MostMatchScreen({super.key});

  @override
  State<MostMatchScreen> createState() => _MostMatchScreenState();
}

class _MostMatchScreenState extends State<MostMatchScreen> {
  final TextEditingController _matchController = TextEditingController();

  /// ARTIST DATA (name + image)
  final List<Map<String, String>> artists = [
    {
      "name": "The Weeknd",
      "image": "assets/images/eminem_3.png",
    },
    {
      "name": "Dua Lipa",
      "image": "assets/images/eminem_2.png",
    },
    {
      "name": "Lana Del Rey",
      "image": "assets/images/eminem_1.png",
    },
    {
      "name": "Eminem",
      "image": "assets/images/eminem_1.png",
    },
    {
      "name": "Drake",
      "image": "assets/images/eminem_2.png",
    },
  ];

  /// MULTI-SELECT SETS
  final Set<String> selectedMusicians = {};
  final Set<String> selectedProducers = {};
  final Set<String> selectedSongWriters = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080322),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 60),

            /// HEADER
            Row(
              children: [
                const Text(
                  'Most Match',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// SEARCH BAR
            TextFormField(
              controller: _matchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search Artist',
                hintStyle: const TextStyle(color: Color(0xFFA9A8A8)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// CONTENT
            Expanded(
              child: ListView(
                children: [
                  _artistCategorySection(
                    title: "Musician",
                    selectedSet: selectedMusicians,
                  ),
                  _artistCategorySection(
                    title: "Producer",
                    selectedSet: selectedProducers,
                  ),
                  _artistCategorySection(
                    title: "Song Writer",
                    selectedSet: selectedSongWriters,
                  ),
                ],
              ),
            ),

            /// NEXT BUTTON
            // nextButton(() {
            //   Get.to(
            //         () {},
            //     arguments: {
            //       "musicians": selectedMusicians.toList(),
            //       "producers": selectedProducers.toList(),
            //       "songWriters": selectedSongWriters.toList(),
            //     },
            //   );
            // }),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// CATEGORY SECTION
  Widget _artistCategorySection({
    required String title,
    required Set<String> selectedSet,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "See all",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 135,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: artists.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, index) {
              final artist = artists[index];
              final name = artist["name"]!;
              final imagePath = artist["image"]!;
              final isSelected = selectedSet.contains(name);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected
                        ? selectedSet.remove(name)
                        : selectedSet.add(name);
                  });
                },
                child: _artistCard(
                  name,
                  imagePath,
                  "6 match",
                  isSelected,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  /// ARTIST CARD (MATCHES YOUR UI)
  Widget _artistCard(
      String name,
      String imagePath,
      String match,
      bool selected,
      ) {
    return SizedBox(
      width: 95,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: selected
                      ? const LinearGradient(
                    colors: [
                      Color(0xFFB84DFF),
                      Color(0xFFFF4FD8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  border: selected
                      ? null
                      : Border.all(
                    color: Colors.white24,
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 36,
                  backgroundImage: AssetImage(imagePath),
                ),
              ),
              if (selected)
                const Positioned(
                  bottom: -2,
                  right: -2,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Color(0xFFB84DFF),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),

          Text(
            match,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
