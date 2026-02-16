import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/messasge/chat_message_model.dart';
import 'package:frnkk/ui/screens/messasge/media_preview.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:get_thumbnail_video/index.dart';

class ChatController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // 1. Single source of truth for messages using the Model
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  late Map<String, dynamic> userData;

  @override
  void onInit() {
    super.onInit();
    userData = Get.arguments as Map<String, dynamic>;
    _loadMockMessages();
    ever(messages, (_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    // We use a small delay to ensure the ListView has rendered the new item
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // 2. Updated Mock Messages to use the Class
  void _loadMockMessages() {
    messages.assignAll([
      ChatMessage(
        text: "Hey brother how are you doing today?",
        isMe: false,
        type: MessageType.text,
        time: DateTime.now(),
      ),
      ChatMessage(
        text: "I'm doing good man. Thanks what about you?",
        isMe: true,
        type: MessageType.text,
        time: DateTime.now(),
      ),
      ChatMessage(
        text: "Check out this video!",
        isMe: false,
        type: MessageType.video, // Example of how video looks in the model
        time: DateTime.now(),
      ),
    ]);
  }

  // 3. Updated Send Message
  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      messages.add(
        ChatMessage(
          text: messageController.text,
          isMe: true,
          type: MessageType.text,
          time: DateTime.now(),
        ),
      );
      messageController.clear();
    }
  }

  // 4. Updated File Picker to use the Class
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      messages.add(
        ChatMessage(
          text: result.files.single.name,
          mediaPath: result.files.single.path,
          isMe: true,
          type: MessageType.file,
          time: DateTime.now(),
        ),
      );
    }
  }

  // Pick Image or Video
  Future<void> pickMedia(ImageSource source, {required bool isVideo}) async {
    final XFile? file = isVideo
        ? await _picker.pickVideo(source: source)
        : await _picker.pickImage(source: source);

    if (file != null) {
      String? generatedThumb;

      if (isVideo) {
        try {
          final String tempPath = (await getTemporaryDirectory()).path;
          final dynamic result = await VideoThumbnail.thumbnailFile(
            video: file.path,
            thumbnailPath: tempPath,
            imageFormat: ImageFormat.JPEG,
            maxHeight: 200,
            quality: 75,
          );
          generatedThumb = (result is String) ? result : result?.path;
        } catch (e) {
          debugPrint("Preview Thumbnail Error: $e");
        }
      }

      // Now pass BOTH the video path and the thumb path to the preview
      _openPreview(
        file.path,
        isVideo ? MessageType.video : MessageType.image,
        previewThumb:
            generatedThumb, // Ensure this name matches the method above
      );
    }
  }

  void _openPreview(String path, MessageType type, {String? previewThumb}) {
    Get.to(
      () => MediaPreviewScreen(
        mediaPath: path,
        thumbnailPath: previewThumb, // 2. Pass it to the widget
        type: type,
        onSend: (caption) {
          // 3. No need to generate it again here! Just use previewThumb
          messages.add(
            ChatMessage(
              text: caption,
              mediaPath: path,
              thumbnailPath: previewThumb,
              type: type,
              isMe: true,
              time: DateTime.now(),
            ),
          );

          Get.back();
        },
      ),
    );
  }

  void showAttachmentOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E20),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOption(
              Icons.image,
              "Image",
              () => pickMedia(ImageSource.gallery, isVideo: false),
            ),
            _buildOption(
              Icons.videocam,
              "Video",
              () => pickMedia(ImageSource.gallery, isVideo: true),
            ),
            _buildOption(Icons.insert_drive_file, "File", pickFile),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Get.back();
        onTap();
      },
    );
  }

  Future<void> sendVideo(String videoPath) async {
    final String tempDir = (await getTemporaryDirectory()).path;

    final dynamic thumb = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: tempDir,
      imageFormat: ImageFormat.JPEG,
      quality: 75,
    );

    final String? finalPath = (thumb is String) ? thumb : thumb?.path;

    messages.add(
      ChatMessage(
        type: MessageType.video,
        mediaPath: videoPath,
        thumbnailPath: finalPath,
        isMe: true,
        time: DateTime.now(),
      ),
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
