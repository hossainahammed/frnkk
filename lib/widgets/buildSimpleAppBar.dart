import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

Widget _buildSimpleAppBar(String title) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: Row(
      children: [
        IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Get.back()),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

Widget _buildPinkSaveButton(VoidCallback onTap) {
  return SizedBox(
    width: double.infinity,
    height: 54.h,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD458FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27.r)),
      ),
      child: Text("Save", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white)),
    ),
  );
}