import 'package:get/get.dart';

class NavigationController extends GetxController {
  // Current active tab index
  var selectedIndex = 0.obs;

  // Method to update index
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}