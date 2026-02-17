import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'package:frnkk/controllers/home_controller.dart';

import 'package:frnkk/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:get/get.dart';

import 'app.dart';

void main() {
  
  Get.put(NavigationController());
  Get.lazyPut(() => HomeController());
  //Get.lazyPut(() => ProfileController());

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const frnkApp(),
    ),
  );
}
