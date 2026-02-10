import 'package:flutter/material.dart';
import 'package:frnkk/Model/ArtistModel.dart';
import 'package:get/get.dart';

class SingerProfileController extends GetxController {
  // --- Tab Logic ---
  var  selectedTab = "Bio".obs;

  // --- About Section State ---
  var isAboutExpanded = false.obs;
  var isEditingAbout = false.obs;
  var aboutText = "Warfaze is another popular music band in Bangladesh. It's known as the Pioneer Heavy Metal Band. It's been active for over 30 years and has released several albums. They are widely regarded as one of the most influential bands in the history of Bangladeshi rock music.".obs;
  late TextEditingController aboutEditController;

  // --- Album Section State ---
  var isAllAlbumsVisible = false.obs;
  final albums = [
    {'title': 'Ocean Blvd', 'artist': 'Salena Gomez', 'image': 'assets/images/music cover_1.png'},
    {'title': 'NFR', 'artist': 'Salena Gomez', 'image': 'assets/images/music cover_2.png'},
    {'title': 'Honeymoon', 'artist': 'Salena Gomez', 'image': 'assets/images/music cover_3.png'},
    {'title': 'Lust for Life', 'artist': 'Salena Gomez', 'image': 'assets/images/music cover_1.png'},
    {'title': 'Ultraviolence', 'artist': 'Salena Gomez', 'image': 'assets/images/music cover_2.png'},
    {'title': 'Blue Banisters', 'artist': 'Salena Gomez', 'image': 'assets/images/music cover_3.png'},
  ].obs;

  // --- Audio List Logic ---
  var isEditingAudio = false.obs;
  var currentPlayingIndex = (-1).obs;
  final audioList = [
    {'title': 'A & W', 'genre': 'Classical', 'artist': 'Salena Gomez', 'image': 'assets/images/music cover_1.png'},
    {'title': 'The Bleckest Day', 'genre': 'Hip Hop', 'artist': 'Lana Del Rey', 'image': 'assets/images/music cover_2.png'},
    {'title': 'The Bleckest Day', 'genre': 'Classical', 'artist': 'Lana Del Rey', 'image': 'assets/images/music cover_3.png'},
    {'title': 'The Bleckest Day', 'genre': 'Pop', 'artist': 'Lana Del Rey', 'image': 'assets/images/music cover_1.png'},
  ].obs;

  // --- Skills & Genres State ---
  late Rx<Artist> artistData;

  // Controllers for the "Add Skill & Genres" Screen
  final newLanguageController = TextEditingController();
  final newLevelController = TextEditingController();
  final newSkillController = TextEditingController();
  final newGenreController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    aboutEditController = TextEditingController(text: aboutText.value);

    // Initializing with the data seen in your screenshots
    artistData = Artist(
      languages: [
        {'name': 'English', 'value': 0.9},
        {'name': 'Spanish', 'value': 0.9},
        {'name': 'Franchi', 'value': 0.9},
      ],
      skills: ["Vocal", "Harmony", "Lyric writing", "Electronic", "Classical"],
      genres: [
        "Hip-hop", "R&B", "Alternative", "Pop", "Rock",
        "Electronic", "Classical", "Jazz", "Experimental",
        "Blues", "House", "Country"
      ],
    ).obs;
  }

  // --- Tab Methods ---
  void changeTab(String tab) => selectedTab.value = tab;

  // --- Bio Methods ---
  void toggleAbout() => isAboutExpanded.value = !isAboutExpanded.value;
  void saveAbout() {
    aboutText.value = aboutEditController.text;
    isEditingAbout.value = false;
  }

  // --- Album Methods ---
  void toggleSeeAllAlbums() => isAllAlbumsVisible.value = !isAllAlbumsVisible.value;

  // --- Audio Methods ---
  void toggleAudioEdit() => isEditingAudio.value = !isEditingAudio.value;
  void playAudio(int index) => currentPlayingIndex.value = (currentPlayingIndex.value == index) ? -1 : index;
  void removeAudio(int index) {
    audioList.removeAt(index);
    if (audioList.isEmpty) isEditingAudio.value = false;
  }

  // --- Edit Skills & Genres Logic ---

  // Language Logic
  void addLanguage() {
    String name = newLanguageController.text.trim();
    // Converts "90%" text to 0.9 double for progress bar
    double value = (double.tryParse(newLevelController.text.replaceAll('%', '')) ?? 0) / 100;

    if (name.isNotEmpty) {
      artistData.update((val) {
        val?.languages.add({'name': name, 'value': value});
      });
      newLanguageController.clear();
      newLevelController.clear();
    }
  }

  void removeLanguage(String name) {
    artistData.update((val) {
      val?.languages.removeWhere((element) => element['name'] == name);
    });
  }

  // Skills Logic
  void addSkill(String skill) {
    if (skill.isNotEmpty) {
      artistData.update((val) {
        val?.skills.add(skill);
      });
      newSkillController.clear();
    }
  }

  void removeSkill(String skill) {
    artistData.update((val) {
      val?.skills.remove(skill);
    });
  }

  // Genres Logic
  void addGenre(String genre) {
    if (genre.isNotEmpty) {
      artistData.update((val) {
        val?.genres.add(genre);
      });
      newGenreController.clear();
    }
  }

  void removeGenre(String genre) {
    artistData.update((val) {
      val?.genres.remove(genre);
    });
  }

  final experienceList = [
    {
      'year': '2025\nPresent',
      'role': 'Lead Vocalist',
      'project': 'Independent Studio Project',
      'duration': '2024 - Present',
      'description': 'Recorded vocals for pop and R&B tracks. Collaborated with producers and lyricists for studio and live projects.',
    },
    {
      'year': '2024\n-2022',
      'role': 'Lead Vocalist',
      'project': 'Independent Studio Project',
      'duration': '2024 - Present',
      'description': 'Recorded vocals for pop and R&B tracks. Collaborated with producers and lyricists for studio and live projects.',
    },
  ].obs;
  @override
  void onClose() {
    aboutEditController.dispose();
    newLanguageController.dispose();
    newLevelController.dispose();
    newSkillController.dispose();
    newGenreController.dispose();
    super.onClose();
  }
}