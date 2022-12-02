import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:flutter_real_todo/controller/image_controller.dart';
import 'package:flutter_real_todo/util/image_pick.dart';
import 'package:get/get.dart';

class ScreenRegister extends StatelessWidget {
  var emailText = TextEditingController();
  var passwordText = TextEditingController();
  var passwordConfirmText = TextEditingController();
  final imageController = Get.put(ImageController());
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
            ImagePick(),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Container(
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 5.0),
                child: TextField(
                  decoration: const InputDecoration(
                      label: Text("email"), border: InputBorder.none),
                  controller: emailText,
                )),
            Container(
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 5.0),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      label: Text("password"), border: InputBorder.none),
                  controller: passwordText,
                )),
            Container(
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 5.0),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      label: Text("password confirm"),
                      border: InputBorder.none,
                  ),
                  controller: passwordConfirmText,
                )),
            SizedBox(
              width: 500,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if(passwordText.text == "" || passwordConfirmText.text == "" ||emailText.text == "") {
                    Get.showSnackbar(const GetSnackBar(
                      message: "모든 정보를 입력해주세요",
                      duration: Duration(seconds: 1),
                    ));
                  }
                  else {
                    if (passwordText.text.trim() ==
                        passwordConfirmText.text.trim()) {
                      userController.SignUp(
                          emailText.text.trim(), passwordText.text.trim(), imageController.pickImage.value.path);
                    } else {
                      Get.showSnackbar(const GetSnackBar(
                        message: "비밀번호가 일치하지 않습니다.",
                        duration: Duration(seconds: 1),
                      ));
                    }
                  }
                },
                child: const Text("회원가입하기"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
