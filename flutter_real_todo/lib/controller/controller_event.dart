import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:flutter_real_todo/model/model_event.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import '../utils.dart';

class MyController extends GetxController {
  final eventModel = Get.put(RxEventModel());
  final userModel = Get.put(UserController());
  final kEventSource = {}.obs;
  final kEvents = {}.obs;
  final dateEvent = [].obs;
  final defaultUrl = "http://localhost:8080";
  final mobileUrl = "http://10.0.2.2:8080";
  final iosUrl = "http://127.0.0.1:8080";

  Future<void> getEvents() async {
    var url = Uri.parse("$defaultUrl/event/getEvents/${userModel.user.value.id}");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/event/getEvents/${userModel.user.value.id}");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/event/getEvents/${userModel.user.value.id}");
      }
    } catch(e) {
      print(e);
    }

    await http.get(url).then((value) {
      kEventSource.clear();

      eventModel.events(json.decode(value.body));
      print(userModel.user.value.id);
      for(var item in eventModel.events) {
        DateTime dateFormat = DateTime.utc(convertDate(item["eventEnd"]).year, convertDate(item["eventEnd"]).month, convertDate(item["eventEnd"]).day);

        if(kEventSource.containsKey(dateFormat)) {
          kEventSource.update(dateFormat, (value)  {
            value.add(Event(item["eventName"], item["eventClear"] == 0 ? false : true, item["eid"], convertDate(item["eventStart"]), convertDate(item["eventEnd"])));
            return value;
          });
        }
        else {
          kEventSource[dateFormat]
          =[Event(item["eventName"], item["eventClear"] == 0 ? false : true, item["eid"], convertDate(item["eventStart"]), convertDate(item["eventEnd"]))];
        }
      }
    });
  }
  Future<void> updateComplete(int id, int complete) async {
    var url = Uri.parse("$defaultUrl/event/updateClear");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/event/updateClear");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/event/updateClear");
      }
    } catch(e) {
      print(e);
    }

    await http.put(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "eid" : id,
        "eventClear" : complete
      })
    ).then((value) {
      if(value.statusCode == 200) {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Event",
            message: "update Complete",
            duration: Duration(seconds: 1),
          ),
        );
        getEvents();
      }
    });
  }

  Future<void> deleteEvent(int id) async {
    var url = Uri.parse("$defaultUrl/event/deleteEvent");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/event/deleteEvent");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/event/deleteEvent");
      }
    } catch(e) {
      print(e);
    }

    await http.delete(
        url,
        headers: {"Content-Type" : "application/json"},
        body: json.encode({
          "eid" : id,
        })
    ).then((value) {
      if(value.statusCode == 200) {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Event",
            message: "Event 삭제 성공",
            duration: Duration(seconds: 2),
          ),
        );
        getEvents();
      }
    });
  }

  DateTime convertDate(String str) {
    return DateTime.parse(str);
  }

  List<Event>? showEvent(day) {
    kEvents.addAll(kEventSource);

    return kEvents[day];
  }

  Future<void> insertEvents() async {
    var url = Uri.parse("$defaultUrl/event/insertEvents");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/event/insertEvents");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/event/insertEvents");
      }
    } catch(e) {
      print(e);
    }

    await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "eventName" : eventModel.eventName.value,
        "eventClear" : eventModel.eventClear.value,
        "eventStart" : eventModel.eventStart.value.toIso8601String(),
        "eventEnd" : eventModel.eventEnd.value.toIso8601String(),
        "users" : {
          "id" : userModel.user.value.id,
          "uuid" : userModel.user.value.email,
          "upassword" : userModel.user.value.password
        }
      }),
    ).then((value) {
      print(value.statusCode);
      if(value.statusCode == 200) {
        Get.showSnackbar(
            const GetSnackBar(
              title: "Event",
              message: "Event가 정상적으로 등록되었습니다.",
              duration: Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
            )
        );
        getEvents();
      } else {
        Get.showSnackbar(
            const GetSnackBar(
              title: "Error",
              message: "Error",
              duration: Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
            )
        );
      }

    });

  }

}