import 'package:get/get.dart';

class SingerProfileController extends GetxController {
  var selectedTab = "Bio".obs;

  final albums = [
    {'title': 'Ocean Blvd', 'artist': 'Salena Gomez', 'image':'assets/images/music cover_1.png'},
    {'title': 'NFR', 'artist': 'Salena Gomez', 'image':'assets/images/music cover_2.png'},
    {'title': 'Honeymoon', 'artist': 'Salena Gomez', 'image':'assets/images/music cover_3.png'},
  ].obs;

  void changeTab(String tab) => selectedTab.value = tab;
}