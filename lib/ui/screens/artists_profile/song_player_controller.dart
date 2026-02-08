import 'package:get/get.dart';

class PlayerController extends GetxController {
  final List<Map<String, String>> playlist;
  var currentIndex = 0.obs; // Observable index

  PlayerController({required this.playlist, required int initialIndex}) {
    currentIndex.value = initialIndex;
  }

  Map<String, String> get currentTrack => playlist[currentIndex.value];

  void nextSong() {
    if (currentIndex.value < playlist.length - 1) {
      currentIndex.value++;
    } else {
      currentIndex.value = 0; // Loop to start
    }
  }

  void previousSong() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    } else {
      currentIndex.value = playlist.length - 1; // Loop to end
    }
  }
}