import 'dart:convert';

import 'package:flutter_todo_mine/controller/controller_user.dart';
import 'package:flutter_todo_mine/model/model_todo.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TodoController extends GetxController {
  final todoModel = Get.put(RxTodoModel());
  final userModel = Get.put(UserController());

  Future<void> insertTodo() async {
    var url = Uri.parse("http://localhost:8080/todo/insertTodos");

    print(todoModel.start.toString());
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
    });
  }
}