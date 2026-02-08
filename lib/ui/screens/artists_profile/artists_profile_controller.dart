import 'package:frnkk/ui/screens/artists_profile/artists_model.dart';
import 'package:get/get.dart';

class ArtistProfileController extends GetxController {
  var artistData = Rxn<Artist>();
  final RxBool isAboutExpanded = false.obs; 
  var selectedTab = "Bio".obs; // Ensure this is exactly like this
  final RxBool isAudioExpanded = false.obs;

  void toggleAudioExpanded() {
    isAudioExpanded.value = !isAudioExpanded.value;
  }

  void changeTab(String tabName) {
    selectedTab.value = tabName;
  }

  void toggleAboutExpanded() {
    isAboutExpanded.value = !isAboutExpanded.value;
  }
 

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args is Artist) {
      artistData.value = args;
    } else {
      artistData.value = ArtistMockData.artists[0];
    }
  }
}