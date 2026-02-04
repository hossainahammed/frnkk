import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/choose_genre_interest_screen.dart';
import 'package:frnkk/widgets/common_widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  final TextEditingController _locationController = TextEditingController();

  String? _selectedCity;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080322),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            SizedBox(height: 60.h),
            Row(
              children: [
                Text(
                  'Choose your location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => print("Skip Tapped"),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            TextFormField(
              controller: _locationController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search  location',
                hintStyle: const TextStyle(color: Color(0xFFA9A8A8)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.r),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio:
                  2.5,
              children: ['Los Angeles', 'New York', 'California', 'Boston'].map(
                (city) {
                  final bool isSelected = _selectedCity == city;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCity = city;
                        _locationController.text = city;
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9).withOpacity(0.16),
                            borderRadius: BorderRadius.circular(1000.r),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.purple
                                  : Colors.white.withOpacity(0.2),
                              width: isSelected ? 2.0 : 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            city,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),

            SizedBox(height: 100.h),
            ImageIcon(
              const AssetImage('assets/images/location.png'),
              color: Colors.purple,
              size: 100.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'Search for location',
              style: GoogleFonts.nunitoSans(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'You can search for location here',
              style: GoogleFonts.poltawskiNowy(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFA9A8A8),
              ),
            ),

            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.only(bottom: 30.h, top: 10.h),
              child: nextButton('Next', () {
                Get.to(
                  () => const ChooseGenreInterestScreen(),
                  transition: Transition.fade,
                  duration: const Duration(milliseconds: 300),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
