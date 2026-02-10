import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/profile_controller.dart';
import 'package:frnkk/ui/screens/Settings/ProfilePhotoView.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final controller = Get.find<ProfileController>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController dobController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: controller.userName.value);
    emailController = TextEditingController(text: controller.userEmail.value);
    dobController = TextEditingController(text: "dd/mm/yyyy");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: const Color(0xFF080322),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Personal Data",
            style: GoogleFonts.nunitoSans(
              color: Colors.white,
              fontSize: 24.sp,
            ),
        ),
      ),
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Column(
            children: [
              SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top),
              Expanded(
                child: Container(
                  width: 1.sw,
                  height: 1.sh,
                  // decoration: const BoxDecoration(
                  //   gradient: RadialGradient(
                  //     center: Alignment.centerRight,
                  //     radius: 1.5,
                  //     colors: [Color(0xFF2D0B4D), Color(0xFF080322)],
                  //   ),
                  // ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        // Profile Photo Section
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 65.r,
                                backgroundImage: const AssetImage('assets/images/Rectangle.png'),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () => Get.to(() => const ProfilePhotoView()),
                                  child: Container(
                                    padding: EdgeInsets.all(8.r),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFF5E5E),
                                      shape: BoxShape.circle,
                                    ),
                                    child: ImageIcon(AssetImage('assets/images/profile_Icon/Vector.png'),color: Colors.white, size: 24.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40.h),

                        // Form Fields
                        _buildLabel("Name"),
                        _buildTextField(nameController),

                        SizedBox(height: 25.h),
                        _buildLabel("Email"),
                        _buildTextField(emailController),

                        SizedBox(height: 25.h),
                        _buildLabel("Date of Birth"),
                        _buildTextField(dobController, isDate: true),

                        SizedBox(height: 25.h),
                        _buildLabel("Country"),
                        _buildDropdownField(),

                        SizedBox(height: 50.h),

                        // Save Button
                        SizedBox(
                          width: double.infinity,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: () => controller.updatePersonalInfo(
                              name: nameController.text,
                              email: emailController.text,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD458FF),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                            ),
                            child: Text(
                              "Save",
                                style: GoogleFonts.poltawskiNowy(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                            ),
                          ),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, {bool isDate = false}) {
    return TextField(
      controller: ctrl,
      style: TextStyle(color: Colors.white70, fontSize: 15.sp),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD458FF))),
        suffixIcon: isDate ? Icon(Icons.calendar_month_outlined, color: Colors.white38, size: 22.sp) : null,
      ),
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      dropdownColor: const Color(0xFF130B2B),
      style: TextStyle(color: Colors.white70, fontSize: 15.sp),
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD458FF))),
      ),
      hint: const Text("Select Your Country", style: TextStyle(color: Colors.white38)),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
      items: ["USA", "Bangladesh", "UK"].map((String val) {
        return DropdownMenuItem(value: val, child: Text(val));
      }).toList(),
      onChanged: (value) {},
    );
  }
}