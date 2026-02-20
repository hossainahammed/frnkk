import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/GigController.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/AddGigScreen.dart';
import 'package:get/get.dart';

class GigDetailsScreen extends StatelessWidget {
  const GigDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GigController>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D0A4E), Color(0xFF080322)],
          ),
        ),
        child: Column(
          children: [
            // 1. Dynamic Header Image with Default Fallback
            Stack(
              children: [
                Obx(() {
                  if (controller.selectedImagePath.value.isEmpty) {
                    // DEFAULT IMAGE if nothing is uploaded
                    return Image.asset(
                      'assets/images/Add_Gig.png',
                      width: double.infinity,
                      height: 300.h,
                      fit: BoxFit.cover,
                    );
                  } else {
                    return Image.file(
                      File(controller.selectedImagePath.value),
                      width: double.infinity,
                      height: 300.h,
                      fit: BoxFit.cover,
                    );
                  }
                }),
                SafeArea(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- FIXED ROW (No more overflow) ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Side
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Singer",
                                style: TextStyle(
                                  color: const Color(0xFFD458FF),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                controller.nameController.text,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                controller.locationController.text,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // Right Side
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                controller.titleController.text,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  controller.skills.join(", "),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.white24, height: 30),

                    Text(
                      "Event Type",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.h),

                    Obx(
                      () => Wrap(
                        spacing: 15.w, // Horizontal space between items
                        runSpacing: 12.h, // Vertical space between lines
                        children: controller.eventTypes.map((event) {
                          return SizedBox(
                            // Calculating width to fit 2 items per row with padding
                            width:
                                (MediaQuery.of(context).size.width / 2) - 30.w,
                            child: _buildRadioButton(
                              "${event['type']} ${event['price']}",
                              true,
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: 25.h),

                    // --- FIXED: Showing content from controller ---
                    _buildSection(
                      "Included",
                      controller.includedController.text,
                    ),
                    SizedBox(height: 25.h),
                    _buildSection(
                      "Excluded",
                      controller.excludedController.text,
                    ),

                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Inside GigDetailsScreen Scaffold
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            // EDIT BUTTON
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: OutlinedButton(
                  onPressed: () =>
                      Get.back(), // Goes back to CreateNewGigScreen
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFD458FF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.r),
                    ),
                  ),
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            SizedBox(width: 15.w),
            // DONE BUTTON
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    // This takes the user back to the AddGigScreen specifically
                    //Get.offAll(() => const AddGigScreen());
                    // This clears form and goes to AddGigScreen
                    controller.completeProcess();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD458FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.r),
                    ),
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          content.isEmpty ? "No details provided." : content,
          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildRadioButton(String text, bool isSelected) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 16.w,
          width: 16.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white70, width: 2),
          ),
          child: isSelected
              ? Center(
                  child: Container(
                    height: 8.w,
                    width: 8.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD458FF),
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : null,
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 13.sp),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Widget _buildRadioButton(String text, bool isSelected) {
  //   return Row(
  //     children: [
  //       Container(
  //         height: 18.w, width: 18.w,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           border: Border.all(color: Colors.white70, width: 2),
  //         ),
  //         child: isSelected ? Center(child: Container(height: 8.w, width: 8.w, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle))) : null,
  //       ),
  //       SizedBox(width: 8.w),
  //       // Added Expanded here to prevent long event names from overflowing
  //       Expanded(child: Text(text, style: TextStyle(color: Colors.white, fontSize: 13.sp))),
  //     ],
  //   );
  // }
}
