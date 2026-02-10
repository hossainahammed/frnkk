import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/singer_profile_controller.dart';
import 'package:get/get.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SingerProfileController>();


    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("All Audio",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold)),
            Obx(() => IconButton(
              onPressed: () => controller.toggleAudioEdit(),
              icon: Icon(
                  controller.isEditingAudio.value
                      ? Icons.check_circle
                      : Icons.edit_note,
                  color: const Color(0xFFD458FF),
                  size: 24.sp),
            )),
          ],
        ),

        Obx(() => ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.audioList.length,
          itemBuilder: (context, index) {
            final audio = controller.audioList[index];
            bool isPlaying = controller.currentPlayingIndex.value == index;

            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(audio['image']!,
                    width: 50.w, height: 50.w, fit: BoxFit.cover),
              ),
              title: Text(audio['title']!,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("${audio['artist']} (${audio['genre']})",
                  style: const TextStyle(color: Colors.white38)),
              trailing: Obx(() => controller.isEditingAudio.value
                  ? IconButton(
                icon: const Icon(Icons.remove_circle_outline,
                    color: Colors.redAccent),
                onPressed: () => _showDeleteConfirmation(
                    context, controller, index),
              )
                  : IconButton(
                icon: Icon(
                  isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_outline,
                  color: isPlaying
                      ? const Color(0xFFD458FF)
                      : Colors.white54,
                ),
                onPressed: () => controller.playAudio(index),
              )),
            );
          },
        )),
      ],
    );


    bool isStandalone = Get.currentRoute.contains('PortfolioView') ||
        ModalRoute.of(context)?.isFirst == false && !Get.currentRoute.contains('SingerProfileScreen');

    if (isStandalone) {
      return Scaffold(
        backgroundColor: const Color(0xFF080322),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text("Portfolio",
              style: TextStyle(color: Colors.white, fontSize: 20.sp)),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: content,
        ),
      );
    }


    return content;
  }

  void _showDeleteConfirmation(
      BuildContext context, SingerProfileController controller, int index) {
    Get.defaultDialog(
        title: "Remove Audio",
        middleText: "Are you sure you want to remove this track?",
        backgroundColor: const Color(0xFF1A1433),
        titleStyle: const TextStyle(color: Colors.white),
        middleTextStyle: const TextStyle(color: Colors.white70),
        textConfirm: "Remove",
        textCancel: "Cancel",
        confirmTextColor: Colors.white,
        buttonColor: const Color(0xFFD458FF),
        onConfirm: () {
          controller.removeAudio(index);
          Get.back();
        });
  }
}