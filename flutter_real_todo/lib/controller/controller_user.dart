import 'dart:convert';
import 'dart:io';
import 'package:flutter_real_todo/controller/controller_event.dart';
import 'package:flutter_real_todo/model/model_user.dart';
import 'package:flutter_real_todo/model/model_users.dart';
import 'package:flutter_real_todo/screens/screen_login.dart';
import 'package:flutter_real_todo/screens/screen_main.dart';
import 'package:flutter_real_todo/screens/screen_tab.dart';
import 'package:get/get.dart';
// import 'dart:io' as platfrom;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'controller_todo.dart';

class UserController extends GetxController {
  final user = User().obs;
  final usersModel = Get.put(RxUsersModel());
  final defaultUrl = "http://localhost:8080";
  final mobileUrl = "http://10.0.2.2:8080";

  void updateEmail(String text) {
    user.update((val) {
      val?.email = text;
    });
  }

  void updatePassword(String password) {
    user.update((val) {
      val?.password = password;
    });
  }

  Future<void> Login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(email);
    print(password);
    var url = Uri.parse("$defaultUrl/user/login");
    try {
      if(Platform.isAndroid || Platform.isIOS) {
        url = Uri.parse("$mobileUrl/user/login");
      }
    } catch(e) {
      print(e);
    }
    // android는 localhost 대신 10.0.2.2
    await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "uuid" : email,
        "upassword" : password
      })
    ).then((value) {
      if(value.statusCode == 200) {
        user.update((val) {
          val?.email = jsonDecode(value.body)["id"];
          val?.password = jsonDecode(value.body)["password"];
          val?.id = jsonDecode(value.body)["pid"];
          val?.cart = jsonDecode(value.body)["cart"];
        });
        print(user.value.cart);
        prefs.setString("id", email);
        prefs.setString("password", password);
        prefs.setBool("isLogin", true);
      }
      else {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Login",
            message: "Login Fail",
          )
        );
      }
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", "");
    prefs.setString("password", "");
    prefs.setBool("isLogin", false);
    Get.off(() => ScreenLogin());
  }

  Future<void> getUsers(String uuid) async {
    var url = Uri.parse("$defaultUrl/user/findUser/$uuid");
    try {
      if(Platform.isAndroid || Platform.isIOS) {
        url = Uri.parse("$mobileUrl/user/findUser/$uuid");
      }
    } catch(e) {
      print(e);
    }
    if(uuid == "") {
      usersModel.users.clear();
    }
    else {
      await http.get(url).then((value) {
        if (value.statusCode == 200) {
          // print(value.body);
          usersModel.users(json.decode(value.body));
          print(usersModel.users[0]["uuid"]);
        }
      });
    }
  }

  Future<void> SignUp(String email, String password) async {
    var url = Uri.parse("$defaultUrl/user/signUp");
    try {
      if(Platform.isAndroid || Platform.isIOS) {
        url = Uri.parse("$mobileUrl/user/signUp");
      }
    } catch(e) {
      print(e);
    }
    await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "uuid" : email,
        "upassword" : password
      })
    ).then((value) {
      Get.showSnackbar(const GetSnackBar(
        title: "Sign Up",
        message: "회원가입에 성공하셨습니다.",
        duration: Duration(seconds: 2),
      ));
      Get.off(() => ScreenLogin());
    });
  }
}