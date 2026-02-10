enum MessageType { text, image, video, file }

class ChatMessage {
  final String? text;
  final String? mediaPath;
  final MessageType type;
  final bool isMe;
  final dynamic time;
  final String? thumbnailPath;

  ChatMessage({
    this.text,
    this.mediaPath,
    required this.type,
    required this.isMe,
    required this.time,
    this.thumbnailPath,
  });
}