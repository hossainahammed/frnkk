import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostMatchsongWriterScreen extends StatefulWidget {
  const MostMatchsongWriterScreen({super.key});

  @override
  State<MostMatchsongWriterScreen> createState() =>
      _MostMatchsongWriterScreenState();
}

class _MostMatchsongWriterScreenState extends State<MostMatchsongWriterScreen> {
  final Set<int> selectedIndices = {};

  final List<Map<String, String>> writers = [
    {"name": "Lana Del Rey", "image": "assets/images/eminem_1.png"},
    {"name": "The Weeknd", "image": "assets/images/eminem_3.png"},
    {"name": "Dua Lipa", "image": "assets/images/eminem_2.png"},
    {"name": "Lana Del Rey", "image": "assets/images/eminem_1.png"},
    {"name": "The Weeknd", "image": "assets/images/eminem_3.png"},
    {"name": "Dua Lipa", "image": "assets/images/eminem_2.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080322),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Row(
                children: [
                  Text(
                    'Song Writer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              _buildSearchField(),
              SizedBox(height: 20.h),
              Text(
                'Song Writer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(bottom: 10.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: writers.length,
                  itemBuilder: (context, index) {
                    final bool isSelected = selectedIndices.contains(index);
                    return GestureDetector(
                      onTap: () => setState(
                        () => isSelected
                            ? selectedIndices.remove(index)
                            : selectedIndices.add(index),
                      ),
                      child: _buildWriterCard(
                        writers[index]['name']!,
                        writers[index]['image']!,
                        isSelected,
                      ),
                    );
                  },
                ),
              ),
              _buildNextButton(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search Song Writer',
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 12.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildWriterCard(String name, String img, bool isSelected) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFB84DFF) : Colors.white10,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 35.r,
                backgroundImage: AssetImage(img),
              ),
            ),
            if (isSelected)
              Positioned(
                bottom: 2.h,
                right: 2.w,
                child: CircleAvatar(
                  radius: 8.r,
                  backgroundColor: const Color(0xFFB84DFF),
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
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "Song Writer",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD458FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        onPressed: () {
          List<String> selectedNames = selectedIndices
              .map((i) => writers[i]['name']!)
              .toList();
          Get.back(result: selectedNames);
        },
        child: Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
