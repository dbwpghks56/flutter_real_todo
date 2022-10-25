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
            Container(
            width: 500,
            decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(bottom: 5.0),
            child :TextField(
              decoration: const InputDecoration(
                  label: Text("password confirm")
              ),
              controller: passwordConfirmText,
            )),
             ElevatedButton(
                onPressed: () {
                  if(passwordText.text.trim() == passwordConfirmText.text.trim()) {
                    userController.SignUp(emailText.text.trim(), passwordText.text.trim());
                  } else {
                    Get.showSnackbar(const GetSnackBar(
                      message: "비밀번호를 확인해주세요",
                      duration: Duration(seconds: 1),
                    ));
                  }
                  },
                child: const Text("회원가입하기")),
          ],
        ),
      ),
    );
  }
}
