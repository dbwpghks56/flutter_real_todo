import 'package:flutter/material.dart';
import 'package:flutter_todo_mine/controller/controller_user.dart';
import 'package:flutter_todo_mine/model/model_user.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ScreenLogin extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            ),Container(
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 5.0),
              child : TextButton(
                  onPressed: () {
                    DatePicker.showTimePicker(context,
                        showTitleActions: true,
                        showSecondsColumn: false,
                        onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm ${date.hour} : ${date.minute}');
                        }, currentTime: DateTime.now(), locale: LocaleType.ko);
                  },
                  child: const Text(
                    'show date time picker (Korea)',
                    style: TextStyle(color: Colors.blue),
                  ),
              ),
            ),
            SizedBox(
              width: 500,
              height: 50,
              child : ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  userController.Login(emailController.text.trim(), passwordController.text.trim());
                },
                child: const Text("LogIn"),
              ),
            ),
          ],
        ),
      )
    );
  }
}
