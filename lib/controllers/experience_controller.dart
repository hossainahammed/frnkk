import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExperienceController extends GetxController {
  // Observables for state management
  var selectedJob = "Singer".obs;
  var selectedAdditional = "Songwriter".obs;
  var isCurrentlyWorking = true.obs;

  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;

  // Function to pick date
  Future<void> pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate.value : endDate.value,
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD458FF),
              onPrimary: Colors.white,
              surface: Color(0xFF1A1433),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (isStartDate) {
        startDate.value = picked;
      } else {
        endDate.value = picked;
      }
    }
  }
}