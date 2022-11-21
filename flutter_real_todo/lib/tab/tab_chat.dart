import 'dart:convert';

import 'package:flutter/material.dart';
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
  StompClient? client;

  @override
  void initState() {
    super.initState();
    setState(() {
      client ??= StompClient(
        config: StompConfig.SockJS(
            url: "http://localhost:8080/stomp/chat",
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
              print("연결시도");
              client!.subscribe(
                destination: '/exchange/chat.exchange/room.1',
                callback: (StompFrame frame) {
                  if (frame.body != null) {
                    Map<String, dynamic> obj = json.decode(frame.body!);
                    print(obj);
                  }
                },
                headers: {

                },
              );
            }
        ),
      );
      client!.activate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                client?.activate();
                client!.send(
                  destination: "/pub/chat.enter.1",
                  body: json.encode({
                    "memeberId" : 1,
                    "nickname" : "nothing",
                    "message" : "jhonna test"
                  }),
                );
              });
            },
            child: const Text("test"),
          )
        ],
      ),
    );
  }
}
