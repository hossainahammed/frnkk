import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';

class NotificationPage extends StatelessWidget {
  final bool hasNotifications; // Logic to toggle between empty/active
  const NotificationPage({super.key, this.hasNotifications = true});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Notification", style: TextStyle(color: Colors.white)),
        ),
        body: hasNotifications ? _buildNotificationList() : _buildEmptyState(),
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/user_image.png'),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        children: [
                          const TextSpan(text: "You have got a new Message from "),
                          TextSpan(
                            text: "Ben Collins", 
                            style: TextStyle(color: Colors.purple[300], fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "09:56 AM | Wednesday",
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/notifications_images/notification.png',width: 100,height: 100,),
          const SizedBox(height: 20),
          const Text("Notifications Empty!", style: TextStyle(color: Colors.white, fontSize: 24)),
          const SizedBox(height: 10),
          Text(
            "No notifications right now.",
            style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}