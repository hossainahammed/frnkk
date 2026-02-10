import 'package:flutter/material.dart';
import 'package:frnkk/ui/screens/messasge/chat_message_model.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:video_player/video_player.dart';

class MediaPreviewScreen extends StatefulWidget {
  final String mediaPath;
  final String? thumbnailPath;
  final MessageType type;
  final Function(String caption)? onSend;

  MediaPreviewScreen({
    required this.mediaPath,
    this.thumbnailPath,
    required this.type,
    this.onSend,
  });

  @override
  State<MediaPreviewScreen> createState() => _MediaPreviewScreenState();
}

class _MediaPreviewScreenState extends State<MediaPreviewScreen> {
  VideoPlayerController? _controller;
  final TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.type == MessageType.video) {
      _controller = VideoPlayerController.file(File(widget.mediaPath))
        ..initialize().then((_) {
          setState(() {}); 
          _controller!.play();
          _controller!.setLooping(true);
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.type == MessageType.image
                ? Image.file(File(widget.mediaPath), fit: BoxFit.contain)
                : _controller != null && _controller!.value.isInitialized
                    ? GestureDetector(
                        onTap: () {
                          // Play/Pause toggle on tap
                          setState(() {
                            _controller!.value.isPlaying 
                                ? _controller!.pause() 
                                : _controller!.play();
                          });
                        },
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!),
                              ),
                              // Show a play icon if the video is paused
                              if (!_controller!.value.isPlaying)
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.black45,
                                  child: Icon(Icons.play_arrow, size: 40, color: Colors.white),
                                ),
                            ],
                          ),
                        ),
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          if (widget.thumbnailPath != null)
                            Image.file(File(widget.thumbnailPath!), fit: BoxFit.contain),
                          const CircularProgressIndicator(color: Colors.white),
                        ],
                      ),
          ),
          // Only show caption input if we are in "Send" mode (onSend is not null)
          if (widget.onSend != null) _buildCaptionInput(),
        ],
      ),
    );
  }

  Widget _buildCaptionInput() {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.black,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: captionController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Add a caption...",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blueAccent),
              onPressed: () {
                if (widget.onSend != null) {
                  widget.onSend!(captionController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}