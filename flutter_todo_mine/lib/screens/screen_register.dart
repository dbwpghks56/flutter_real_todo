import 'package:flutter/material.dart';
import 'package:flutter_todo_mine/controller/controller_user.dart';
import 'package:get/get.dart';

class ScreenRegister extends StatelessWidget {
  var emailText = TextEditingController();
  var passwordText = TextEditingController();
  var passwordConfirmText = TextEditingController();
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text("email")
              ),
              controller: emailText,
            ),
            TextField(
              decoration: const InputDecoration(
                  label: Text("password")
              ),
              controller: passwordText,
            ),
            TextField(
              decoration: const InputDecoration(
                  label: Text("password confirm")
              ),
              controller: passwordConfirmText,
            ),
            passwordText.text == passwordConfirmText.text
            ? ElevatedButton(
                onPressed: () {
                  userController.SignUp(emailText.text.trim(), passwordText.text.trim());
                  },
                child: const Text("회원가입하기")) :
            ElevatedButton(
                onPressed: () {
                  Get.showSnackbar(const GetSnackBar(
                    message: "비밀번호가 다릅니다.",
                    duration: Duration(seconds: 1),
                  ));
                  },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                child: const Text("회원가입하기")),
          ],
        ),
      ),
    );
  }
}
