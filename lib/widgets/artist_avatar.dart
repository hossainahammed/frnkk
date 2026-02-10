import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArtistAvatar extends StatelessWidget {
  final String imagePath;
  final String name;
  final String match;
  final bool selected;

  const ArtistAvatar({
    super.key,
    required this.imagePath,
    required this.name,
    required this.match,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? Colors.purple : Colors.transparent,
                  width: 2.w,
                ),
              ),
              child: CircleAvatar(
                radius: 32.r,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            if (selected)
              Positioned(
                bottom: 0.h,
                right: 0.w,
                child: CircleAvatar(
                  radius: 8.r,
                  backgroundColor: Colors.purple,
                  child: Icon(
                    Icons.check,
                    size: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        Text(
          match,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
