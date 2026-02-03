import 'package:flutter/material.dart';
import 'package:frnkk/controllers/MusicSelectionController.dart' show MusicSelectionController;
import 'package:frnkk/ui/screens/most_match_screen.dart';
import 'package:frnkk/widgets/common_widgets.dart';
import 'package:get/get.dart';


class ChooseGenreInterestScreen extends StatefulWidget {
  const ChooseGenreInterestScreen({super.key});

  @override
  State<ChooseGenreInterestScreen> createState() => _ChooseGenreInterestScreenState();
}

class _ChooseGenreInterestScreenState extends State<ChooseGenreInterestScreen> {
  final TextEditingController _genreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080322),
      body: GetBuilder<MusicSelectionController>(
        init: MusicSelectionController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Row(
                  children: [
                    const Text(
                      'Choose your genre',
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
                  controller: _genreController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search  Genre',
                    hintStyle: const TextStyle( color: const Color(0xFFA9A8A8),),

                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(48)),
                  ),
                ),

                 const SizedBox(height: 24),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGenreWrap(controller.genres, controller.selectedGenres, (val) => controller.toggleGenre(val)),
                        const SizedBox(height: 30),
                        const Text("Choose your interest", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        ...controller.selectedInterests.keys.map((category) => _buildInterestSection(category, controller)).toList(),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 10),
                  child:nextButton(() {
                    Get.to(() => const MostMatchScreen());
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildGenreWrap(List<String> list, List<String> selectedList, Function(String) onSelected) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: list.map((item) {
        bool isSelected = selectedList.contains(item);
        return GestureDetector(
          onTap: () => onSelected(item),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isSelected ? Colors.purple : Colors.white24),
              color: isSelected ? Colors.purple.withOpacity(0.2) : Colors.white12,
            ),
            child: Text(item, style: const TextStyle(color: Colors.white)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInterestSection(String title, MusicSelectionController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
            TextButton(onPressed: () {}, child: const Text("See all", style: TextStyle(color: Colors.white70, fontSize: 12,decoration: TextDecoration.underline,decorationColor: Colors.white,))),
          ],
        ),

        _buildGenreWrap(controller.genres, controller.selectedInterests[title]!, (val) => controller.toggleInterest(title, val)),
        const SizedBox(height: 20),
      ],
    );
  }
}