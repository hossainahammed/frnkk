import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/SelectGenderScreen.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:frnkk/widgets/common_widgets.dart'; // Assuming AppDecorations is defined here or imported via this
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTypeScreen extends StatefulWidget {
  const SelectTypeScreen({super.key});

  @override
  State<SelectTypeScreen> createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  int selectedIndex = 0;

  final List<String> types = [
    'Singer',
    'Musician',
    'Producer',
    'Song Writer',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                children: [
                  SizedBox(height: 60.h), // Top spacing
                  Text(
                    'Select Your Type',
                    style: GoogleFonts.poltawskiNowy(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  ...List.generate(types.length, (index) {
                    return typeTile(
                      title: types[index],
                      selected: selectedIndex == index,
                      onTap: () => setState(() => selectedIndex = index),
                    );
                  }),

                  SizedBox(height: 32.h),

                  nextButton('Next', () {
                    Get.to(() => const SelectGenderScreen(), transition: Transition.fade);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}