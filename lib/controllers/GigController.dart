import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/AddGigScreen.dart';
import 'package:frnkk/ui/screens/Singer_profileView_and_Setup/GigDetailsScreen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../ui/screens/Singer_profileView_and_Setup/CreateNewGigScreen.dart';

// --- The Gig Model ---
class GigModel {
  String title;
  String name;
  String location;
  String imagePath;
  List<String> skills;
  List<Map<String, String>> eventTypes;
  String included;
  String excluded;

  GigModel({
    required this.title,
    required this.name,
    required this.location,
    required this.imagePath,
    required this.skills,
    required this.eventTypes,
    required this.included,
    required this.excluded,
  });
}

class GigController extends GetxController {
  // Observables
  var skills = <String>['Vocal', 'Electronic', 'Harmony'].obs;
  var eventTypes = <Map<String, String>>[
    {'type': 'Party', 'price': '200\$/Hr'},
  ].obs;
  var selectedImagePath = ''.obs;

  // This list will hold all published gigs
  var publishedGigs = <GigModel>[].obs;

  // Controllers
  final titleController = TextEditingController();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final skillInputController = TextEditingController();
  final eventTypeInputController = TextEditingController();
  final eventPriceInputController = TextEditingController();
  final includedController = TextEditingController();
  final excludedController = TextEditingController();

  void addSkill(String skill) {
    if (skill.trim().isNotEmpty && !skills.contains(skill.trim())) {
      skills.add(skill.trim());
      skillInputController.clear();
    }
  }

  void removeSkill(String skill) => skills.remove(skill);

  void addEventType() {
    String type = eventTypeInputController.text.trim();
    String price = eventPriceInputController.text.trim();
    if (type.isNotEmpty && price.isNotEmpty) {
      eventTypes.add({'type': type, 'price': '$price\$/Hr'});
      eventTypeInputController.clear();
      eventPriceInputController.clear();
    }
  }

  void removeEventType(int index) => eventTypes.removeAt(index);

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        selectedImagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar("Error", "Could not access gallery");
    }
  }

  // --- UPDATED PUBLISH LOGIC ---
  // --- UPDATED PUBLISH LOGIC ---
  var editingIndex =
      (-1).obs; // -1 means we are creating a new gig, not editing

  // Load data into controllers for editing
  void loadGigForEdit(int index) {
    editingIndex.value = index;
    GigModel gig = publishedGigs[index];

    titleController.text = gig.title;
    nameController.text = gig.name;
    locationController.text = gig.location;
    includedController.text = gig.included;
    excludedController.text = gig.excluded;
    selectedImagePath.value = gig.imagePath;
    skills.value = List.from(gig.skills);
    eventTypes.value = List.from(gig.eventTypes);

    Get.to(() => const CreateNewGigScreen());
  }

  void publishGig() {
    GigModel gigData = GigModel(
      title: titleController.text,
      name: nameController.text,
      location: locationController.text,
      imagePath: selectedImagePath.value,
      skills: skills.toList(),
      eventTypes: eventTypes.toList(),
      included: includedController.text,
      excluded: excludedController.text,
    );

    if (editingIndex.value == -1) {
      // Create new
      publishedGigs.add(gigData);
    } else {
      // Update existing
      publishedGigs[editingIndex.value] = gigData;
      editingIndex.value = -1; // Reset after update
    }

    publishedGigs.refresh();
    Get.to(() => const GigDetailsScreen());
  }
  // void publishGig() {
  //   if (titleController.text.isEmpty) {
  //     Get.snackbar("Error", "Please enter a Gig Title",
  //         backgroundColor: Colors.redAccent, colorText: Colors.white);
  //     return;
  //   }
  //
  //   // 1. Create the Gig object with HARD COPIES of the lists
  //   GigModel newGig = GigModel(
  //     title: titleController.text,
  //     name: nameController.text,
  //     location: locationController.text,
  //     imagePath: selectedImagePath.value,
  //     skills: skills.toList(), // Convert RxList to standard List
  //     eventTypes: eventTypes.toList(), // Convert RxList to standard List
  //     included: includedController.text,
  //     excluded: excludedController.text,
  //   );
  //
  //   // 2. Add to the list and FORCE refresh
  //   publishedGigs.add(newGig);
  //   publishedGigs.refresh(); // This forces Obx to wake up
  //
  //   // 3. Navigate
  //   Get.to(() => const GigDetailsScreen());
  // }

  void completeProcess() {
    _resetForm();
    // Use Get.offAll to go back and REBUILD the screen from scratch
    Get.offAll(() => const AddGigScreen());
  }
  //   void publishGig() {
  //     if (titleController.text.isEmpty) {
  //       Get.snackbar("Error", "Please enter a Gig Title",
  //           backgroundColor: Colors.redAccent, colorText: Colors.white);
  //       return;
  //     }
  //
  //     // 1. Create the Gig object and add to list
  //     GigModel newGig = GigModel(
  //       title: titleController.text,
  //       name: nameController.text,
  //       location: locationController.text,
  //       imagePath: selectedImagePath.value,
  //       skills: List.from(skills),
  //       eventTypes: List.from(eventTypes),
  //       included: includedController.text,
  //       excluded: excludedController.text,
  //     );
  //
  //     publishedGigs.add(newGig);
  //
  //     // 2. Go to Details Screen first so the user can see their work
  //     Get.to(() => const GigDetailsScreen());
  //
  //     // Note: We DO NOT call _resetForm() here anymore.
  //     // We call it after the user presses "Done" in the details screen.
  //   }
  //
  //   // Create this helper to clean up after everything is finished
  //   void completeProcess() {
  //     _resetForm();
  //     Get.offAll(() => const AddGigScreen());
  //   }

  void _resetForm() {
    titleController.clear();
    nameController.clear();
    locationController.clear();
    includedController.clear();
    excludedController.clear();
    skills.value = ['Vocal', 'Electronic', 'Harmony'];
    eventTypes.value = [
      {'type': 'Party', 'price': '200\$/Hr'},
    ];
    selectedImagePath.value = '';
  }
}
