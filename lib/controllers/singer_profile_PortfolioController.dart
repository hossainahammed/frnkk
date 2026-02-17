import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class PortfolioController extends GetxController {
  // Reactive variables to store file names
  var audioFileName = "".obs;
  var albumFileName = "".obs;

  // Function to pick audio files
  Future<void> pickAudioFile(bool isAlbum) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4', 'wav'],
    );

    if (result != null) {
      if (isAlbum) {
        albumFileName.value = result.files.first.name;
      } else {
        audioFileName.value = result.files.first.name;
      }
    }
  }
}