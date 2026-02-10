import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/InitialSetupFlow/SelectLocationScreen.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:frnkk/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectGenderScreen extends StatefulWidget {
  const SelectGenderScreen({super.key});

  @override
  State<SelectGenderScreen> createState() => _SelectGenderScreenState();
}

class _SelectGenderScreenState extends State<SelectGenderScreen> {
  int selectedGender = 0; // 0 = male, 1 = female

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Container(
            //color: const Color(0xFF080322),
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select Your Gender',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = 0;
                          });
                        },
                        child: genderCard(
                          imagePath: 'assets/images/M.png',
                          selected: selectedGender == 0,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = 1;
                          });
                        },
                        child: genderCard(
                          imagePath: 'assets/images/F.png',
                          selected: selectedGender == 1,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                Padding(
                  padding: EdgeInsets.only(bottom: 30.h, top: 10.h),
                  child: nextButton(
                    'Next',
                        () {
                      Get.to(
                            () => const SelectLocationScreen(),
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}