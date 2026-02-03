import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/SelectLocationScreen.dart';
import 'package:frnkk/widgets/common_widgets.dart';
import 'package:get/get.dart';

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
      body: Container(
        color: const Color(0xFF080322),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Your Gender',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
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
                const SizedBox(width: 16),
                GestureDetector(
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
              ],
            ),

            const SizedBox(height: 32),

            nextButton(() {
              Get.to(() => const SelectLocationScreen());
            }),
          ],
        ),
      ),
    );
  }
}
