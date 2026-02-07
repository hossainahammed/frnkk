import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddGigScreen extends StatelessWidget {
  const AddGigScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.white, size: 18.sp),
                    label: Text("Create New Gig", style: TextStyle(color: Colors.white, fontSize: 13.sp)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD458FF)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    ),
                  ),
                ),
              ),

              // --- Gigs List ---
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: 5,
                  itemBuilder: (context, index) => _buildGigCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGigCard() {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset('assets/images/gig_thumb.png', width: 90.w, height: 90.w, fit: BoxFit.cover),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Singer", style: TextStyle(color: const Color(0xFFD458FF), fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    const Icon(Icons.more_vert, color: Colors.white70, size: 20),
                  ],
                ),
                Text("Salena Gomez", style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                Text("Dhanmondi, Dhaka", style: TextStyle(color: Colors.white38, fontSize: 12.sp)),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("300 \$-500\$", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    Text("Pop, Rock, Bangla", style: TextStyle(color: Colors.white70, fontSize: 11.sp)),
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
}