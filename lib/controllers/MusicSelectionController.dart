import 'package:get/get.dart';

class MusicSelectionController extends GetxController {
  // Genre Selection
  List<String> genres = ['Hip-hop', 'R&B', 'Alternative', 'Pop', 'Rock', 'Electronic', 'Classical', 'Jazz', 'Experimental', 'Blues', 'House', 'Country'];
  List<String> selectedGenres = [];

  // Interest Selection
  Map<String, List<String>> selectedInterests = {
    'Musician': [],
    'Producer': [],
    'Song Writer': [],
  };

  void toggleGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      selectedGenres.remove(genre);
    } else {
      selectedGenres.add(genre);
    }
    update(); // Triggers GetBuilder to rebuild
  }

  void toggleInterest(String category, String genre) {
    if (selectedInterests[category]!.contains(genre)) {
      selectedInterests[category]!.remove(genre);
    } else {
      selectedInterests[category]!.add(genre);
    }
    update();
  }
}