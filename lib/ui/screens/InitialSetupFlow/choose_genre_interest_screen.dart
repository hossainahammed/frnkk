import 'package:flutter/material.dart';
import 'package:frnkk/controllers/MusicSelectionController.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/most_match_screen.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:frnkk/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseGenreInterestScreen extends StatefulWidget {
  const ChooseGenreInterestScreen({super.key});

  @override
  State<ChooseGenreInterestScreen> createState() =>
      _ChooseGenreInterestScreenState();
}

class _ChooseGenreInterestScreenState extends State<ChooseGenreInterestScreen> {
  final TextEditingController _genreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFF080322),
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          GetBuilder<MusicSelectionController>(
            init: MusicSelectionController(),
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                    Row(
                      children: [
                        Text(
                          'Choose your genre',
                          style: GoogleFonts.poltawskiNowy(
                            color: Colors.white,
                            fontSize: 24.sp,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {Get.to(
                                () => const MostMatchScreen(),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 300),
                          );},
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
                    TextFormField(
                      controller: _genreController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search Genre',
                        hintStyle: const TextStyle(color: Color(0xFFA9A8A8)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(48.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildGenreGrid(
                              controller.genres,
                              controller.selectedGenres,
                              (val) => controller.toggleGenre(val),
                              isExpanded: true,
                            ),
                            SizedBox(height: 30.h),
                            Text(
                              "Choose your interest",
                              style: GoogleFonts.nunitoSans(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            ...controller.selectedInterests.keys.map(
                              (category) =>
                                  _buildInterestSection(category, controller),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.h, top: 10.h),
                      child: nextButton('Next', () {
                        Get.to(
                          () => const MostMatchScreen(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 300),
                        );
                      }),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInterestSection(
    String title,
    MusicSelectionController controller,
  ) {
    bool isExpanded = controller.expandedCategories.contains(title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
            TextButton(
              onPressed: () => controller.toggleExpand(title),
              child: Text(
                isExpanded ? "See less" : "See all",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.sp,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        _buildGenreGrid(
          controller.genres,
          controller.selectedInterests[title]!,
          (val) => controller.toggleInterest(title, val),
          isExpanded: isExpanded,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildGenreGrid(
      List<String> list,
      List<String> selectedList,
      Function(String) onSelected, {
        required bool isExpanded,
      }) {
    int displayCount = isExpanded
        ? list.length
        : (list.length > 12 ? 12 : list.length);
    List<String> displayList = list.take(displayCount).toList();

    return Wrap(
      spacing: 8.w, // Horizontal space between chips
      runSpacing: 10.h, // Vertical space between lines
      children: displayList.map((item) {
        bool isSelected = selectedList.contains(item);
        return GestureDetector(
          onTap: () => onSelected(item),
          child: IntrinsicWidth( // Ensures the chip only takes up needed width
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? Colors.purple : Colors.white24,
                ),
                color: isSelected
                    ? Colors.purple.withOpacity(0.2)
                    : Colors.white12,
              ),
              child: Text(
                item,
                style: GoogleFonts.poltawskiNowy(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontSize: 14.sp, // Slightly smaller to fit better on one line
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
  // Widget _buildGenreGrid(
  //   List<String> list,
  //   List<String> selectedList,
  //   Function(String) onSelected, {
  //   required bool isExpanded,
  // }) {
  //   int displayCount = isExpanded
  //       ? list.length
  //       : (list.length > 12 ? 12 : list.length);
  //   List<String> displayList = list.take(displayCount).toList();
  //
  //   return GridView.count(
  //     crossAxisCount: 4,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     mainAxisSpacing: 10.h,
  //     crossAxisSpacing: 10.w,
  //     childAspectRatio: 2.8,
  //     children: displayList.map((item) {
  //       bool isSelected = selectedList.contains(item);
  //       return GestureDetector(
  //         onTap: () => onSelected(item),
  //         child: Container(
  //           padding: EdgeInsets.all(3),
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20.r),
  //             border: Border.all(
  //               color: isSelected ? Colors.purple : Colors.white24,
  //             ),
  //             color: isSelected
  //                 ? Colors.purple.withOpacity(0.2)
  //                 : Colors.white12,
  //           ),
  //           child: Text(
  //             item,
  //             style: GoogleFonts.poltawskiNowy(
  //               color: Colors.white60,
  //               fontSize: 16.sp,
  //               fontWeight: FontWeight.w400,
  //
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }
}
