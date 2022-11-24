import 'dart:convert';
import 'dart:io';
import 'package:flutter_real_todo/tab/tab_chat.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_real_todo/model/model_chat.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ChatController extends GetxController {
  final chatModel = Get.put(RxChatModel());
  final _chats = [].obs;
  final roomId = 0.obs;
  final _rooms = [].obs;
  final defaultUrl = "http://localhost:8080";
  final mobileUrl = "http://10.0.2.2:8080";
  final iosUrl = "http://127.0.0.1:8080";

  get chats => _chats.value;
  get chatsLang => _chats.value.length;
  set chats(value) => _chats.value = value;
  get rooms => _rooms.value;
  get roomsLang => _rooms.value.length;
  set rooms(value) => _rooms.value = value;

  Future<void> getChats(Map<String, dynamic> obj) async {
    _chats.add(obj);
  }

  Future<void> getChats2(int uId, int tId) async {
    var url = Uri.parse("$defaultUrl/chat/room/$uId/$tId");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/chat/room/$uId/$tId");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/chat/room/$uId/$tId");
      }
    } catch(e) {
      print(e);
    }

    await http.get(url).then((value) async {
      _chats.clear();
      roomId.value = json.decode(value.body);
      await getChats3(roomId.value);
      Get.to(() => TabChat());
    });
  }

  Future<void> getChats3(int roomId) async {
    var url = Uri.parse("$defaultUrl/chat/getChats/$roomId");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/chat/getChats/$roomId");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/chat/getChats/$roomId");
      }
    } catch(e) {
      print(e);
    }

    await http.get(url).then((value) {
      _chats(json.decode(value.body));
      Get.to(() => TabChat());
    });
  }

  Future<void> getRooms(int uid) async {
    var url = Uri.parse("$defaultUrl/chat/getRooms/$uid");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/chat/getRooms/$uid");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/chat/getRooms/$uid");
      }
    } catch(e) {
      print(e);
    }

    await http.get(url).then((value) {
      _rooms(json.decode(value.body));
    });
  }
}











