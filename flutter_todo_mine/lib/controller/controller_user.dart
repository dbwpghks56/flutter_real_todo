import 'dart:convert';

import 'package:flutter_todo_mine/model/model_user.dart';
import 'package:flutter_todo_mine/screens/screen_main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final user = User().obs;

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
    var url = Uri.parse("http://localhost:8080/user/login"); // android는 localhost 대신 10.0.2.2
    await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "uuid" : email,
        "upassword" : password
      })
    ).then((value) {
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
      Get.off(() => ScreenMain(), transition: Transition.cupertino);
    });
  }

  Future<void> SignUp(String email, String password) async {
    var url = Uri.parse("http://localhost:8080/user/signUp");
    await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "uuid" : email,
        "upassword" : password
      })
    ).then((value) {
      if(value == 1) {
        Get.showSnackbar(const GetSnackBar(
          title: "Sign Up",
          message: "회원가입에 성공하셨습니다.",
          duration: Duration(seconds: 2),
        ));
      }
      else {
        Get.showSnackbar(const GetSnackBar(
          title: "Sign Up",
          message: "회원가입에 실패하셨습니다. 다시 시도해주세요.",
          duration: Duration(seconds: 2),
        ));
      }
    });
  }
}