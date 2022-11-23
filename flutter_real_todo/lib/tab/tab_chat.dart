import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_chat.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:flutter_real_todo/model/model_chat.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/sock_js/sock_js_utils.dart';
import 'package:stomp_dart_client/sock_js/sock_js_parser.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class TabChat extends StatefulWidget {

  @override
  _TabChatState createState() => _TabChatState();
}

class _TabChatState extends State<TabChat> {
  final userService = Get.put(UserController());
  final chatService = Get.put(ChatController());
  TextEditingController message = TextEditingController();
  StompClient? client;

  @override
  void initState() {
    super.initState();
    setState(() {
      if(client == null) {
        client = StompClient(
          config: StompConfig.SockJS(
              url: "${userService.user.value.defaultUrl}/stomp/chat",
              webSocketConnectHeaders: {
                "transports" : ["websocket"]
              },
              onWebSocketError: (p0) {
                print(p0);
              },
              onStompError: (p0) {
                print(p0);
              },
              onConnect:(StompFrame frame) {
                client!.subscribe(
                  destination: '/exchange/chat.exchange/room.1',
                  callback: (StompFrame frame) async {
                    if (frame.body != null) {
                      Map<String, dynamic> obj = json.decode(frame.body!);
                      // print(obj);
                      chatService.getChats(obj);
                      print(chatService.chats);
                    }
                  },
                  headers: {

                  },
                );
              }
          ),
        );
        client!.activate();
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    client!.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return Expanded(
                child: ListView.builder(
                  itemCount: chatService.chatsLang,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: chatService.chats[index]["id"] == userService.user.value.id ?
                      const EdgeInsets.only(left: 100,bottom: 10) : const EdgeInsets.only(right: 100,bottom: 10),
                      child:Text(
                          chatService.chats[index]["message"],
                          textAlign: chatService.chats[index]["id"] == userService.user.value.id ? TextAlign.right : TextAlign.left,
                      ),

                    );
                  },
                  padding: const EdgeInsets.only(bottom: 10),
                )
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(padding: EdgeInsets.only(left: 10)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.indigoAccent,
                  ),
                ),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: message,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "보낼 메시지를 입력하세요.",
                    border: InputBorder.none
                  ),
                )
              ),
              const Padding(padding: EdgeInsets.only(left: 5)),
              Expanded(
                child: Container(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        client!.send(
                          destination: "/pub/chat.message.1",
                          body: json.encode({
                            "chatRoomId" : 1,
                            "memberId" : userService.user.value.email,
                            "id" : userService.user.value.id.toString(),
                            "message" : message.text.trim(),
                          }),
                        );
                        message.text = "";
                      });
                    },
                    child: const Icon(Icons.send),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),

        ],
      ),
    );
  }
}
