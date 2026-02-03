import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/choose_genre_interest_screen.dart';
import 'package:frnkk/widgets/common_widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

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
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              children: [
                const Text(
                  'Choose your location',
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => print("Skip Tapped"),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: _locationController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search  location',
                hintStyle: const TextStyle( color: const Color(0xFFA9A8A8),),

                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(48)),
              ),
            ),

            const SizedBox(height: 24),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ['Los Angeles', 'New York', 'California', 'Boston'].map((city) {
                final bool isSelected = _selectedCity == city;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCity = city;
                      _locationController.text = city;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9).withOpacity(0.16),
                          borderRadius: BorderRadius.circular(1000),
                          border: Border.all(
                            color: isSelected ? Colors.purple : Colors.white.withOpacity(0.2),
                            width: isSelected ? 2.0 : 1.5,
                          ),
                        ),
                        child: Text(
                          city,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),


            const Spacer(),
            ImageIcon(const AssetImage('assets/images/location.png'), color: Colors.purple, size: 100),
            const SizedBox(height: 12),
            Text('Search for location',
                style: GoogleFonts.nunitoSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),),
            const SizedBox(height: 12),
            Text(
              'You can search for location here',
              style: GoogleFonts.poltawskiNowy(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFA9A8A8),
              ),
            ),

            const SizedBox(height: 32),

            nextButton(() {
              Get.to(() => const ChooseGenreInterestScreen());
            }),
          ],
        ),
      ),
    );
  }
}
