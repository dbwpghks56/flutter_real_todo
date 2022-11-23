import 'package:flutter_real_todo/model/model_chat.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ChatController extends GetxController {
  final chatModel = Get.put(RxChatModel());
  final _chats = [].obs;

  get chats => _chats.value;
  get chatsLang => _chats.value.length;
  set chats(value) => _chats.value = value;

  Future<void> getChats(Map<String, dynamic> obj) async {
    _chats.add(obj);
  }
}