import 'package:flutter/material.dart';
import 'package:flutter_todo_mine/model/model_user.dart';
import 'package:get/get.dart';

class ScreenLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(User());

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return Form(
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (text) {

                      },
                    )
                  ],
                ),
              );
            }),
          ],
        ),
      )
    );
  }
}
