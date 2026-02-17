import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frnkk/controllers/profile_controller.dart';
import 'package:frnkk/ui/screens/Settings/ProfilePhotoView.dart';
import 'package:frnkk/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';

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
  late TextEditingController countryController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: controller.userName.value);
    emailController = TextEditingController(text: controller.userEmail.value);
    dobController = TextEditingController(text: controller.userDob.value);
    countryController = TextEditingController(
      text: controller.userCountry.value,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 365 * 18),
      ), // Default to 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD458FF),
              onPrimary: Colors.white,
              surface: Color(0xFF130B2B),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF080322),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dobController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
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
          style: GoogleFonts.nunitoSans(color: Colors.white, fontSize: 24.sp),
        ),
      ),
      body: Stack(
        children: [
          AppDecorations.buildFullBackground(),
          Column(
            children: [
              SizedBox(
                height:
                    AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top,
              ),
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
                                backgroundImage: const AssetImage(
                                  'assets/images/Rectangle.png',
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () =>
                                      Get.to(() => const ProfilePhotoView()),
                                  child: Container(
                                    padding: EdgeInsets.all(8.r),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFF5E5E),
                                      shape: BoxShape.circle,
                                    ),
                                    child: ImageIcon(
                                      AssetImage(
                                        'assets/images/profile_Icon/Vector.png',
                                      ),
                                      color: Colors.white,
                                      size: 24.sp,
                                    ),
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
                        _buildTextField(countryController, isCountry: true),

                        SizedBox(height: 50.h),

                        // Save Button
                        SizedBox(
                          width: double.infinity,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: () => controller.updatePersonalInfo(
                              name: nameController.text,
                              email: emailController.text,
                              dob: dobController.text,
                              country: countryController.text,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD458FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
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
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl, {
    bool isDate = false,
    bool isCountry = false,
  }) {
    return TextField(
      controller: ctrl,
      readOnly: isDate || isCountry,
      onTap: isDate
          ? () => _selectDate(context)
          : isCountry
          ? () {
              showCountryPicker(
                context: context,
                showPhoneCode: false,
                onSelect: (Country country) {
                  setState(() {
                    countryController.text =
                        "${country.flagEmoji} ${country.name}";
                  });
                },
                countryListTheme: CountryListThemeData(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  backgroundColor: const Color(0xFF080322),
                  textStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
                  searchTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  inputDecoration: InputDecoration(
                    hintText: 'Search Country',
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(Icons.search, color: Colors.white38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                  ),
                ),
              );
            }
          : null,
      style: TextStyle(color: Colors.white70, fontSize: 15.sp),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD458FF)),
        ),
        suffixIcon: (isDate || isCountry)
            ? Icon(
                isDate
                    ? Icons.calendar_month_outlined
                    : Icons.keyboard_arrow_down,
                color: Colors.white38,
                size: 22.sp,
              )
            : null,
      ),
    );
  }
}
