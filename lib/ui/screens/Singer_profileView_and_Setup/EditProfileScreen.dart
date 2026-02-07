import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/AddBioScreen.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/AddExperienceScreen.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/AddPortfolioScreen.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/ExperienceTabView.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/SingerProfilePortfolioSelfViewScreen.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/add_skills_genres_screen.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080322),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text("Edit Profile",
            style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            _buildEditOption("Add Bio", () => Get.to(() => const AddBioScreen())),
            _buildEditOption("Add Portfolio", () => Get.to(() => const AddPortfolioScreen())),
            _buildEditOption("Add Skill & Genres", () => Get.to(() => const AddSkillsGenresScreen())),
            _buildEditOption("Add Experience", () => Get.to(() => const AddExperienceScreen())),
          ],
        ),
      ),
    );
  }

  Widget _buildEditOption(String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title, style: const TextStyle(color: Colors.white)),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 18),
          onTap: onTap,
        ),
        const Divider(color: Colors.white12),
      ],
    );
  }
}