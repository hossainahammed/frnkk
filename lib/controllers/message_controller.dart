import 'package:frnkk/routes/app_routes.dart';
import 'package:frnkk/ui/screens/messasge/chat_view.dart';
import 'package:get/get.dart';

class MessageListController extends GetxController {
  var conversations = [].obs;
  
  // 1. Create a reactive variable to track which index is tapped
  var selectedIndex = (-1).obs; 

  @override
  void onInit() {
    super.onInit();
    loadConversations();
  }

  void loadConversations() {
    conversations.assignAll(List.generate(10, (index) => {
      "name": "Salena Gomez",
      "image": "assets/images/artists_profile_images/selena.png",
      "lastActivity": "12 Aug 2022 - 12:55 am",
      "hasUnread": index % 3 == 0, 
    }));
  }

  // 2. Update the index when navigating to the chat
  void goToChat(int index, Map chatData) {
    selectedIndex.value = index; 
   // Get.toNamed('/chat', arguments: chatData);
   //  Get.to(()=>ChatScreen());
    Get.toNamed(AppRoutes.chat, arguments: chatData);
    //ChatScreen
  }
}