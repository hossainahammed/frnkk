import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/SelectGenderScreen.dart';
import 'package:frnkk/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


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
      body: Container(
        color: Color(0xFF080322),
        //decoration: bgGradient(),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Your Type',
              style: GoogleFonts.poltawskiNowy(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),
            ),
            const SizedBox(height: 24),

            ...List.generate(types.length, (index) {
              return typeTile(
                title: types[index],
                selected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              );
            }),

            const SizedBox(height: 32),

            nextButton(() {
              Get.to(() => const SelectGenderScreen());
            }),
          ],
        ),
      ),
    );
  }
}
