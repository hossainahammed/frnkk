import 'package:flutter/material.dart';
import 'package:frnkk/routes/app_routes.dart';
import 'package:frnkk/ui/screens/Subscription/SubscriptionScreen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/most_match_musician_screen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/most_match_producer_screen.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/most_match_songwriter_screen.dart';
import 'package:frnkk/ui/screens/home/home_view.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MostMatchScreen extends StatefulWidget {
  const MostMatchScreen({super.key});

  @override
  State<MostMatchScreen> createState() => _MostMatchScreenState();
}

class _MostMatchScreenState extends State<MostMatchScreen> {
  final TextEditingController _matchController = TextEditingController();

  /// ARTIST DATA (name + image)
  final List<Map<String, String>> artists = [
    {"name": "The Weeknd", "image": "assets/images/eminem_3.png"},
    {"name": "Dua Lipa", "image": "assets/images/eminem_2.png"},
    {"name": "Lana Del Rey", "image": "assets/images/eminem_1.png"},
    {"name": "Eminem", "image": "assets/images/eminem_1.png"},
    {"name": "Drake", "image": "assets/images/eminem_2.png"},
  ];

  /// MULTI-SELECT SETS
  final Set<String> selectedMusicians = {};
  final Set<String> selectedProducers = {};
  final Set<String> selectedSongWriters = {};

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use Stack to layer the background widgets behind the UI
      body: Stack(
        children: [
          // 1. This puts the exact multi-glow background you wanted
          AppDecorations.buildFullBackground(),

          // 2. This is your UI content layered on top
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 30.h), // Adjusted for SafeArea

                  /// HEADER
                  Row(
                    children: [
                      Text(
                        'Most Match',
                        style: GoogleFonts.poltawskiNowy(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.offAllNamed(AppRoutes.home),
                        child: Text(
                          'Skip',
                          style: GoogleFonts.poltawskiNowy(
                            color: Colors.white,
                            fontSize: 18.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// SEARCH BAR
                  TextFormField(
                    controller: _matchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search Artist',
                      hintStyle: const TextStyle(color: Color(0xFFA9A8A8)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// CONTENT
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h, top: 10.h),
                    child: nextButton('Get Started', () {
                     // Get.to(() => const HomeScreen(), transition: Transition.fade);
                      Get.offAll(() => const HomeScreen(), transition: Transition.fade);
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
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
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            GestureDetector(
              onTap: () async {
                if (title == "Musician") {
                  var result = await Get.to(
                    () => const MostMatchMusicianScreen(),
                  );

                  if (result != null) {
                    setState(() {
                      selectedMusicians.clear();
                      selectedMusicians.addAll(result);
                    });
                  }
                } else if (title == "Producer") {
                  var result = await Get.to(
                    () => const MostMatchProducerScreen(),
                  );

                  if (result != null) {
                    setState(() {
                      selectedProducers.clear();
                      selectedProducers.addAll(result);
                    });
                  }
                } else if (title == "Song Writer") {
                  var result = await Get.to(
                    () => const MostMatchsongWriterScreen(),
                  );

                  if (result != null) {
                    setState(() {
                      selectedSongWriters.clear();
                      selectedSongWriters.addAll(result);
                    });
                  }
                }
              },
              child: Text(
                "See all",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        SizedBox(
          height: 135.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: artists.length,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
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
                child: _artistCard(name, imagePath, "6 match", isSelected),
              );
            },
          ),
        ),

        SizedBox(height: 24.h),
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
      width: 95.w,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: selected
                      ? const LinearGradient(
                          colors: [Color(0xFFB84DFF), Color(0xFFFF4FD8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  border: selected
                      ? null
                      : Border.all(color: Colors.white24, width: 1.5),
                ),
                child: CircleAvatar(
                  radius: 36.r,
                  backgroundImage: AssetImage(imagePath),
                ),
              ),
              if (selected)
                Positioned(
                  bottom: -2.h,
                  right: -2.w,
                  child: CircleAvatar(
                    radius: 10.r,
                    backgroundColor: const Color(0xFFB84DFF),
                    child: Icon(Icons.check, color: Colors.white, size: 14.sp),
                  ),
                ),
            ],
          ),

          SizedBox(height: 8.h),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          Text(
            match,
            style: TextStyle(color: Colors.white54, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _matchController.dispose();
    super.dispose();
  }
}
