import 'package:flutter/material.dart';
import 'package:frnkk/controllers/message_controller.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageListScreen extends GetView<MessageListController> {
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MessageListController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () => Get.back(),
        // ),
        title: Text(
          "Message",
          style: GoogleFonts.poltawskiNowy(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AppBackground(
        child: SafeArea(
          child: Obx(
            () => ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: controller.conversations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final chat = controller.conversations[index];
                return _buildMessageTile(chat, index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageTile(Map chat, int index) {
    return _MessageTile(
      chat: chat,
      onTap: () => controller.goToChat(index, chat),
    );
  }
}

class _MessageTile extends StatefulWidget {
  final Map chat;
  final VoidCallback onTap;

  const _MessageTile({required this.chat, required this.onTap});

  @override
  State<_MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<_MessageTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        widget.onTap();
        // Keep it pink for a short duration while navigation starts
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) setState(() => _isPressed = false);
        });
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: _isPressed
              ? const Color.fromARGB(255, 210, 82, 222)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          minTileHeight: 63,
          leading: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(widget.chat['image']),
                ),
              ),
              if (widget.chat['hasUnread'])
                Positioned(
                  right: 2,
                  top: 1,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            widget.chat['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Last Activity",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                widget.chat['lastActivity'],
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
