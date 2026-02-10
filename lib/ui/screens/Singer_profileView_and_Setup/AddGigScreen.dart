import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/GigController.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/CreateNewGigScreen.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddGigScreen extends StatelessWidget {
  const AddGigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensuring we use the permanent controller instance
    final GigController controller = Get.put(GigController(), permanent: true);

    return Scaffold(
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  // decoration: const BoxDecoration(
                  //   gradient: LinearGradient(
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: [Color(0xFF2D0A4E), Color(0xFF080322)],
                  //   ),
                  // ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        // --- App Bar ---
                        _buildSimpleAppBar("Add Gig"),

                        // --- Create New Gig Button ---
                        Padding(
                          padding: EdgeInsets.only(right: 20.w, bottom: 10.h),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Reset editing state before creating a new one
                                controller.editingIndex.value = -1;
                                Get.to(() => const CreateNewGigScreen());
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                              label: Text(
                                "Create New Gig",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFFD458FF),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // --- DYNAMIC GIGS LIST ---
                        Expanded(
                          child: Obx(() {
                            if (controller.publishedGigs.isEmpty) {
                              return Center(
                                child: Text(
                                  "No Gigs added yet.\nClick '+' to create one!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              itemCount: controller.publishedGigs.length,
                              itemBuilder: (context, index) {
                                final gig = controller.publishedGigs[index];
                                // Pass the index and controller to the card
                                return _buildGigCard(gig, index, controller);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // UPDATED: Added index and controller parameters
  Widget _buildGigCard(GigModel gig, int index, GigController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dynamic Image Handling
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: gig.imagePath.isEmpty
                ? Image.asset(
                    'assets/images/Add_Gig.png',
                    width: 90.w,
                    height: 90.w,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(gig.imagePath),
                    width: 90.w,
                    height: 90.w,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      gig.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFFD458FF),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // --- UPDATED: 3-DOT MENU WITH EDIT & CANCEL ---
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white70),
                      color: const Color(0xFF2D0A4E),
                      offset: const Offset(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      onSelected: (value) {
                        if (value == 'edit') {
                          controller.loadGigForEdit(index);
                        } else if (value == 'delete') {
                          // Simple delete logic
                          controller.publishedGigs.removeAt(index);
                          Get.snackbar(
                            "Deleted",
                            "Gig removed successfully",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white12,
                            colorText: Colors.white,
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text(
                                "Edit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Delete",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      gig.name,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    Spacer(),
                    Text(
                      gig.eventTypes.isNotEmpty
                          ? gig.eventTypes[0]['price']!
                          : "N/A",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      gig.location,
                      style: TextStyle(color: Colors.white38, fontSize: 12.sp),
                    ),

                    Flexible(
                      child: Text(
                        gig.skills.join(", "),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleAppBar(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          Text(
            title,
            style: GoogleFonts.poltawskiNowy(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
