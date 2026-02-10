import 'package:flutter/material.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostMatchMusicianScreen extends StatefulWidget {
  const MostMatchMusicianScreen({super.key});

  @override
  State<MostMatchMusicianScreen> createState() =>
      _MostMatchMusicianScreenState();
}

class _MostMatchMusicianScreenState extends State<MostMatchMusicianScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> musicians = [
    {"name": "The Weeknd", "image": "assets/images/eminem_3.png"},
    {"name": "Dua Lipa", "image": "assets/images/eminem_2.png"},
    {"name": "Lana Del Rey", "image": "assets/images/eminem_1.png"},
    {"name": "The Weeknd", "image": "assets/images/eminem_3.png"},
    {"name": "Dua Lipa", "image": "assets/images/eminem_2.png"},
    {"name": "Lana Del Rey", "image": "assets/images/eminem_1.png"},
    {"name": "The Weeknd", "image": "assets/images/eminem_3.png"},
    {"name": "Dua Lipa", "image": "assets/images/eminem_2.png"},
    {"name": "Lana Del Rey", "image": "assets/images/eminem_1.png"},
  ];

  final Set<String> selectedMusicians = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080322),
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          SafeArea(
            child: Container(
              // decoration: const BoxDecoration(
              //   gradient: RadialGradient(
              //     center: Alignment.topRight,
              //     radius: 1.5,
              //     colors: [Color(0xFF2D0B4D), Color(0xFF080322)],
              //   ),
              // ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
                    Row(
                      children: [
                        Text(
                          'Musician',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: ()=>Get.back(),
                          child: Text(
                            'Skip',
                            style: TextStyle(
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
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search Artist',
                        hintStyle: const TextStyle(color: Color(0xFFA9A8A8)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(48.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),
                    Text(
                      "Musician",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    /// GRID OF ARTISTS
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.only(bottom: 10.h), // Reduced padding
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15.h,
                          crossAxisSpacing: 10.w,
                          childAspectRatio:
                              0.75,
                        ),
                        itemCount: musicians.length,
                        itemBuilder: (context, index) {
                          final artist = musicians[index];
                          final String name = artist["name"]!;
                          // Note: In a real app, use index if names are identical
                          final bool isSelected = selectedMusicians.contains(
                            name + index.toString(),
                          );

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedMusicians.remove(name + index.toString());
                                } else {
                                  selectedMusicians.add(name + index.toString());
                                }
                              });
                            },
                            child: _buildArtistItem(
                              name,
                              artist["image"]!,
                              isSelected,
                            ),
                          );
                        },
                      ),
                    ),

                    /// NEXT BUTTON
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back(result: selectedMusicians.toList());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD458FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                25.r,
                              ),
                            ),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistItem(String name, String imagePath, bool isSelected) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: const Color(0xFFFF4FD8), width: 2)
                    : Border.all(color: Colors.transparent, width: 2),
              ),
              child: CircleAvatar(
                radius: 35.r,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            if (isSelected)
              Positioned(
                bottom: 3.h,
                right: 3.w,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFFB84DFF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.sp,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "6 match",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
