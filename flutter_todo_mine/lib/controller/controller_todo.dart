import 'dart:convert';
import 'dart:io';

import 'package:flutter_todo_mine/controller/controller_user.dart';
import 'package:flutter_todo_mine/model/model_todo.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TodoController extends GetxController {
  final todoModel = Get.put(RxTodoModel());
  final userModel = Get.put(UserController());
  final defaultUrl = "http://localhost:8080";
  final mobileUrl = "http://10.0.2.2:8080";

  Future<void> getTodos() async {
    var url = Uri.parse("$defaultUrl/todo/getTodos/${userModel.user.value.id}");
    try {
      if(Platform.isAndroid || Platform.isIOS) {
        url = Uri.parse("$mobileUrl/todo/getTodos/${userModel.user.value.id}");
      }
    } catch(e) {
      print(e);
    }
    await http.get(url).then((value) {
      todoModel.todos(json.decode(value.body));
    });
  }
  
  Future<void> insertTodo() async {
    var url = Uri.parse("$defaultUrl/todo/insertTodos");
    try {
      if(Platform.isAndroid || Platform.isIOS) {
        url = Uri.parse("$mobileUrl/todo/insertTodos");
      }
    } catch(e) {
      print(e);
    }
    await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "todoName" : todoModel.name.toString(),
        "startTime" : todoModel.start.toString(),
        "endTime" : todoModel.end.toString(),
        "users" : {
          "id" : userModel.user.value.id,
          "uuid" : userModel.user.value.email,
          "upassword" : userModel.user.value.password
        }
      }),
    ).then((value) {
      Get.showSnackbar(const GetSnackBar(
        title: "Todos",
        message: "Todo 등록에 성공했습니다.",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));
      todoModel.name("name");
      todoModel.start("start-time");
      todoModel.end("end-time");
      getTodos();
    });
  }
}