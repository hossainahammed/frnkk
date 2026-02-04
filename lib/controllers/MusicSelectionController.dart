import 'package:get/get.dart';

class MusicSelectionController extends GetxController {
  List<String> genres = [
    'Hip-hop', 'R&B', 'Alternative', 'Pop', 'Rock', 'Electronic',
    'Classical', 'Jazz', 'Experimental', 'Blues', 'House', 'Country',
    'Folk', 'Metal', 'Soul', 'Techno', 'Disco', 'Punk',
  ];

  List<String> selectedGenres = [];

  List<String> expandedCategories = [];

  Map<String, List<String>> selectedInterests = {
    'Musician': [],
    'Producer': [],
    'Song Writer': [],
  };

  void toggleGenre(String genre) {
    selectedGenres.contains(genre) ? selectedGenres.remove(genre) : selectedGenres.add(genre);
    update();
  }

  void toggleInterest(String category, String genre) {
    selectedInterests[category]!.contains(genre)
        ? selectedInterests[category]!.remove(genre)
        : selectedInterests[category]!.add(genre);
    update();
  }

  // Toggle See All / See Less
  void toggleExpand(String category) {
    if (expandedCategories.contains(category)) {
      expandedCategories.remove(category);
    } else {
      expandedCategories.add(category);
    }
    update();
  }
}