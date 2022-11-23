import 'dart:convert';
import 'dart:io';

import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:flutter_real_todo/model/model_todo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TodoController extends GetxController {
  final todoModel = Get.put(RxTodoModel());
  final userModel = Get.put(UserController());
  final defaultUrl = "http://localhost:8080";
  final mobileUrl = "http://10.0.2.2:8080";
  final iosUrl = "http://127.0.0.1:8080";

  Future<void> getTodos() async {
    var url = Uri.parse("$defaultUrl/todo/getTodos/${userModel.user.value.id}");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/todo/getTodos/${userModel.user.value.id}");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/todo/getTodos/${userModel.user.value.id}");
      }
    } catch(e) {
      print(e);
    }
    await http.get(url).then((value) {
      todoModel.todos(json.decode(value.body));
    });
  }

  Future<void> deleteTodo(Map<String, dynamic> todo) async {
    var url = Uri.parse("$defaultUrl/todo/delteTodo");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/todo/delteTodo");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/todo/delteTodo");
      }
    } catch(e) {
      print(e);
    }
    await http.delete(
      url,
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode({
        "id" : todo["id"]
      }),
    ).then((value) {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Todo",
          message: "Todo 삭제에 성공했습니다.",
          duration: Duration(
            seconds: 1
          ),
        )
      );
      getTodos();
    });
  }

  Future<void> updateTodo(int id) async {
    var url = Uri.parse("$defaultUrl/todo/updateTodo");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/todo/updateTodo");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/todo/updateTodo");
      }
    } catch(e) {
      print(e);
    }

    await http.put(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "id" : id,
        "todoName" : todoModel.name.toString(),
        "startTime" : todoModel.start.toString(),
        "endTime" : todoModel.end.toString(),
        "tabColor" : todoModel.tabColor.value,
        "users" : {
          "id" : userModel.user.value.id,
          "uuid" : userModel.user.value.email,
          "upassword" : userModel.user.value.password
        }
      })
    ).then((value) {
      Get.showSnackbar(const GetSnackBar(
        title: "Todos",
        message: "Todo 수정에 성공했습니다.",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));
      todoModel.name("name");
      todoModel.start("start-time");
      todoModel.end("end-time");
      getTodos();
    });
  }
  
  Future<void> insertTodo() async {
    var url = Uri.parse("$defaultUrl/todo/insertTodos");
    try {
      if(Platform.isAndroid) {
        url = Uri.parse("$mobileUrl/todo/insertTodos");
      } else if(Platform.isIOS) {
        url = Uri.parse("$iosUrl/todo/insertTodos");
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
        "tabColor" : todoModel.tabColor.value,
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