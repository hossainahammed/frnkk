import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Background Gradient
BoxDecoration bgGradient() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF2D033B),
        Color(0xFF810CA8),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

/// Type Selection Tile
Widget typeTile({
  required String title,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: selected ? Colors.purple : Colors.white54,
          width: 2.w,
        ),
      ),
      child: Row(
        children: [
          Icon(
            selected
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: Colors.purple,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Gender Card
Widget genderCard({
  required String imagePath,
  required bool selected,
}) {
  return Container(
    width: 173.w,
    height: 173.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(
        color: selected ? Colors.purple : Colors.transparent,
        width: 2.w,
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Background Image
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),

          /// Selection Overlay
          if (selected)
            Container(
              color: Colors.purple.withOpacity(0.35),
            ),
        ],
      ),
    ),
  );
}

Widget nextButton(String buttonText, VoidCallback onTap) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h),
      ),
      onPressed: onTap,
      child: Text(
        buttonText,
        style: GoogleFonts.poltawskiNowy(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );
}