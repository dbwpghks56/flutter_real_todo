import 'dart:convert';
import 'dart:io';
import 'package:flutter_real_todo/model/model_exercise.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'controller_user.dart';

class ExerciseController extends GetxController {
  final exerciseService = Get.put(ExerciseModel());
  final userModel = Get.put(UserController());
  final defaultUrl = "http://localhost:8080";
  final mobileUrl = "http://10.0.2.2:8080";
  final iosUrl = "http://127.0.0.1:8080";

  Future<void> insertExercises() async {
    var url = Uri.parse("$defaultUrl/exer");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/exer");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/exer");
      }
    } catch(e) {
      print(e);
    }

    await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        exerciseService.toJson()
      }),
    );
  }

  Future<void> getExercises() async {
    var url = Uri.parse("$defaultUrl/exer/${userModel.user.value.id}");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/exer/${userModel.user.value.id}");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/exer/${userModel.user.value.id}");
      }
    } catch(e) {
      print(e);
    }

    await http.get(
      url
    ).then((value) {
      if(value.statusCode == 200) {
        ExerciseModel.fromJson(json.decode(value.body));
      }
    });
  }

}















