import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_chat.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TabChat extends StatefulWidget {

  @override
  _TabChatState createState() => _TabChatState();
}

class _TabChatState extends State<TabChat> {
  final userService = Get.put(UserController());
  final chatService = Get.put(ChatController());
  TextEditingController message = TextEditingController();
  StompClient? client;

  var _flutterLocalNotificationsPlugin;

  void onSelectNotification(String? payload) async {
    debugPrint("$payload");
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Notification Payload'),
          content: Text('Payload: $payload'),
        ));
  }

//await _flutterLocalNotificationPlugin.~ 에서 payload부분은 모두 설정하여 주지 않아도 됩니다.
//버튼을 눌렀을때 한번 알림이 뜨게 해주는 방법입니다.
  Future<void> _showNotification(String content) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin!.show(
      0,
      '메시지가 도착했습니다.',
      content,
      platformChannelSpecifics,
      payload: content,
    );
  }
  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    //ios 알림 설정 : 소리, 뱃지 등을 설정하여 줄수가 있습니다.
    var initializationSettingsIOS = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    //onSelectNotification의 경우 알림을 눌렀을때 어플에서 실행되는 행동을 설정하는 부분입니다.
    //onSelectNotification는 없어도 되는 부분입니다. 어떤 행동을 취하게 하고 싶지 않다면 그냥 비워 두셔도 됩니다.
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
                      obj["id"] != userService.user.value.id ? _showNotification(obj["message"]) : null;
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
