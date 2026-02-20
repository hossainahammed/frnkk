import 'package:frnkk/routes/app_routes.dart';
import 'package:frnkk/ui/screens/messasge/chat_view.dart';
import 'package:get/get.dart';

class MessageListController extends GetxController {
  var conversations = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadConversations();
  }

  void loadConversations() {
    conversations.assignAll(
      List.generate(
        10,
        (index) => {
          "name": "Salena Gomez",
          "image": "assets/images/artists_profile_images/selena.png",
          "lastActivity": "12 Aug 2022 - 12:55 am",
          "hasUnread": index % 3 == 0,
        },
      ),
    );
  }

  void goToChat(int index, Map chatData) {
    Get.toNamed(AppRoutes.chat, arguments: chatData);
  }
}
