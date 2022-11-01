import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:flutter_real_todo/model/model_user.dart';
import 'package:flutter_real_todo/screens/screen_register.dart';
import 'package:flutter_real_todo/screens/screen_tab.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../controller/controller_todo.dart';

class ScreenLogin extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final userController = Get.put(UserController());
  final todoservice = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 5.0),
              child : TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text("email"),
                  border: InputBorder.none,
                  hintText: "email"
                ),
              ),
            ),
            Container(
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 5.0),
              child : TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                    label: Text("password"),
                    border: InputBorder.none,
                    hintText: "password"
                ),
              ),
            ),
            SizedBox(
              width: 500,
              height: 50,
              child : ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () async {
                  await userController.Login(emailController.text.trim(), passwordController.text.trim());
                  await todoservice.getTodos();
                  Get.off(() => ScreenTab(), transition: Transition.cupertino);
                },
                child: const Text("LogIn"),
              ),
            ),
            TextButton(onPressed: () {
                Get.to(ScreenRegister());
              },
              child: const Text("회원가입하러 가기"),
            ),
          ],
        ),
      )
    );
  }
}
