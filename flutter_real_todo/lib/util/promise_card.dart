import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:get/get.dart';

class PromiseCard extends StatelessWidget {
  final dynamic promise;
  final dynamic client;
  final int roomId;
  final userService = Get.put(UserController());
  PromiseCard({required this.promise, required this.client, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 100, left: 100, bottom: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text("약속 : ${promise["eventName"]}",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Text("${convertFormat(DateTime.fromMillisecondsSinceEpoch(promise["eventStart"]))} ~ "
                "${convertFormat(DateTime.fromMillisecondsSinceEpoch(promise["eventEnd"]))}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            promise["users"]["id"] != userService.user.value.id ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent
                    ),
                    child: const Text("거절"),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      client!.send(
                        destination: "/pub/chat.allow.$roomId",
                        body: json.encode({
                          "eid" : promise["eid"].toString(),
                          "allow" : true,
                        }),
                      );
                    },
                    child: const Text("수락"),
                  ),
                ),
              ],
            ) : const Text("응답 대기중입니다.",style: TextStyle(
                fontSize: 14,
                color: Colors.grey
            ),),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
          ],
        ),
      ),
    );
  }
}

String convertFormat(DateTime date) {
  return "${date.year}-${date.month}-${date.day}";
}