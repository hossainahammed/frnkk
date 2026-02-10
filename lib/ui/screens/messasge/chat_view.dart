import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/messasge/chat_controller.dart';
import 'package:frnkk/ui/screens/messasge/chat_message_model.dart';
import 'package:frnkk/ui/screens/messasge/media_preview.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';

import 'dart:io';


class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.toNamed(
                  '/message-settings',
                  arguments: controller.userData,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(controller.userData['image']),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          controller.userData['name'],
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("Today", style: TextStyle(color: Colors.white54)),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final msg = controller.messages[index];
                      return _buildChatBubble(msg);
                    },
                  ),
                ),
              ),
              _buildInputArea(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage msg) {
    bool isMe = msg.isMe;
    MessageType type = msg.type;
    String? path = msg.mediaPath;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF2E1C3C) : const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. IMAGE DISPLAY (Now using the clickable helper)
            if (type == MessageType.image && path != null) _buildImagePreview(msg),

            // 2. VIDEO DISPLAY
            if (type == MessageType.video) _buildVideoPreview(msg),

            // 3. FILE DISPLAY
            if (type == MessageType.file)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.description, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      msg.text ?? "File",
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

            // TEXT CAPTION
            if (type != MessageType.file && msg.text != null && msg.text!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  top: (path != null || type == MessageType.video) ? 8.0 : 0,
                ),
                child: Text(
                  msg.text!,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(ChatMessage msg) {
    return GestureDetector(
      onTap: () {
        if (msg.mediaPath != null) {
          Get.to(() => MediaPreviewScreen(
                mediaPath: msg.mediaPath!,
                type: MessageType.image,
                onSend: null, // Shows image in "View Mode" (hides input)
              ));
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(msg.mediaPath!),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 200,
            height: 200,
            color: Colors.grey,
            child: const Icon(Icons.broken_image, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPreview(ChatMessage msg) {
    return GestureDetector(
      onTap: () {
        if (msg.mediaPath != null) {
          Get.to(() => MediaPreviewScreen(
                mediaPath: msg.mediaPath!,
                thumbnailPath: msg.thumbnailPath,
                type: MessageType.video,
                onSend: null,
              ));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        width: 250,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: msg.thumbnailPath != null
              ? DecorationImage(
                  image: FileImage(File(msg.thumbnailPath!)),
                  fit: BoxFit.cover,
                )
              : null,
          color: Colors.black45,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white38,
              child: Icon(Icons.play_arrow, color: Colors.white, size: 35),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
          color: Colors.white.withOpacity(0.05),
        ),
        child: Row(
          children: [
            const SizedBox(width: 5),
            IconButton(
              onPressed: () => controller.showAttachmentOptions(),
              icon: const Icon(Icons.add, color: Colors.white70, size: 28),
            ),
            Expanded(
              child: TextField(
                controller: controller.messageController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Text Message",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w300,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            IconButton(
              onPressed: controller.sendMessage,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Image.asset(
                "assets/images/message_icons/send.png",
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}