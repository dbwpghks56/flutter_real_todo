import 'dart:convert';

import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:get/get.dart';

import '../model/model_event.dart';

class DatePick extends StatelessWidget {
  final eventName = TextEditingController();
  final eventModel = Get.put(RxEventModel());
  final userService = Get.put(UserController());
  final dynamic client;
  final int roomId; // id test

  DatePick({required this.client, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child:
        SizedBox(
            height: 500,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 300,
                  child: DateTimePicker(
                    type: DateTimePickerType.Date,
                    initialSelectedDate: DateTime.now(),
                    datePickerTitle: "약속 시작 일",
                    onDateChanged: (date) {
                      eventModel.eventStart(date);
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: DateTimePicker(
                    type: DateTimePickerType.Date,
                    initialSelectedDate: DateTime.now(),
                    datePickerTitle: "끝나는 일",
                    onDateChanged: (date) {
                      eventModel.eventEnd(date);
                    },
                  ),
                ),
                Container(
                  width: 290,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child : TextField(
                    controller: eventName,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "약속이름을 설정해주세요."
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                      child: const Text("cancel"),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    ElevatedButton(
                      onPressed: () {
                        eventModel.eventName(eventName.text.trim());
                        client!.send(
                          destination: "/pub/chat.promise.$roomId",
                          body: json.encode({
                            "eventName" : eventModel.eventName.value,
                            "eventStart" : eventModel.eventStart.value.toIso8601String(),
                            "eventEnd" : eventModel.eventEnd.value.toIso8601String(),
                            "eventClear" : 0,
                            "users" : {
                              "id" : userService.user.value.id
                            }
                          }),
                        );
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: const Text("save"),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                  ],
                )
              ],
            )
        )
    );
  }
}
