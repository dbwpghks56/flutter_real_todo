import 'dart:convert';
import 'dart:io';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:flutter_real_todo/model/model_event.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class MyController extends GetxController {
  final eventModel = Get.put(RxEventModel());
  final userModel = Get.put(UserController());

  final defaultUrl = "http://localhost:8080";
  final mobileUrl = "http://10.0.2.2:8080";

  Future<void> insertEvents() async {
    var url = Uri.parse("$defaultUrl/event/insertEvents");
    try {
      if(Platform.isAndroid || Platform.isIOS) {
        url = Uri.parse("$mobileUrl/event/insertEvents");
      }
    } catch(e) {
      print(e);
    }

    await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "eventName" : eventModel.eventName,
        "eventContent" : eventModel.eventContent,
        "eventClear" : eventModel.eventClear,
        "eventStart" : eventModel.eventStart,
        "eventEnd" : eventModel.eventEnd,
        "users" : {
          "id" : userModel.user.value.id,
          "uuid" : userModel.user.value.email,
          "upassword" : userModel.user.value.password
        }
      }),
    ).then((_) {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Event",
          message: "Event가 정상적으로 등록되었습니다.",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        )
      );
    });

  }

}