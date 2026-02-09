import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostMatchProducerScreen extends StatefulWidget {
  const MostMatchProducerScreen({super.key});

  @override
  State<MostMatchProducerScreen> createState() => _MostMatchProducerScreenState();
}

class _MostMatchProducerScreenState extends State<MostMatchProducerScreen> {
  final Set<int> selectedIndices = {};

  final List<Map<String, String>> producers = [
    {"name": "Metro Boomin", "image": "assets/images/eminem_1.png"},
    {"name": "Dr. Dre", "image": "assets/images/eminem_2.png"},
    {"name": "Pharrell", "image": "assets/images/eminem_3.png"},
    {"name": "Metro Boomin", "image": "assets/images/eminem_1.png"},
    {"name": "Dr. Dre", "image": "assets/images/eminem_2.png"},
    {"name": "Pharrell", "image": "assets/images/eminem_3.png"},
    {"name": "Metro Boomin", "image": "assets/images/eminem_1.png"},
    {"name": "Dr. Dre", "image": "assets/images/eminem_2.png"},
    {"name": "Pharrell", "image": "assets/images/eminem_3.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080322),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),

            /// TOP HEADER
            Row(
              children: [
                Text(
                  'Producer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: ()=>Get.back(),
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

            /// SEARCH BAR
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search Producer',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.r),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
              ),
            ),

            SizedBox(height: 25.h),

            /// SECTION TITLE
            Text(
              'Producer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 15.h),

            /// PRODUCER GRID
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: 20.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 0.8,
                ),
                itemCount: producers.length,
                itemBuilder: (context, index) {
                  final bool isSelected = selectedIndices.contains(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedIndices.remove(index);
                        } else {
                          selectedIndices.add(index);
                        }
                      });
                    },
                    child: _buildProducerCard(
                      producers[index]['name']!,
                      producers[index]['image']!,
                      isSelected,
                    ),
                  );
                },
              ),
            ),

            /// NEXT BUTTON
            Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD458FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed: () {
                    // Send back the selected names to the main screen
                    List<String> selectedNames = selectedIndices
                        .map((i) => producers[i]['name']!)
                        .toList();
                    Get.back(result: selectedNames);
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
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

  /// PRODUCER CARD WIDGET
  Widget _buildProducerCard(String name, String img, bool isSelected) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFB84DFF) : Colors.white10,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 38.r,
                backgroundImage: AssetImage(img),
              ),
            ),
            if (isSelected)
              Positioned(
                bottom: 2.h,
                right: 2.w,
                child: CircleAvatar(
                  radius: 10.r,
                  backgroundColor: const Color(0xFFB84DFF),
                  child: Icon(
                    Icons.check,
                    size: 12.sp,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Text(
          "Producer",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}