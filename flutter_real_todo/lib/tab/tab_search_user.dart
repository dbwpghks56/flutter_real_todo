import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:flutter_real_todo/model/model_users.dart';
import 'package:get/get.dart';

class TabSearchUser extends StatelessWidget {

  final searchText = TextEditingController();
  final userService = Get.put(UserController());
  final usersModel = Get.put(RxUsersModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 500,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.only(left: 5, right: 5),
          margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
          child : TextField(
            controller: searchText,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "검색할 유저를 입력해주세요.",
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            autofocus: true,
            onChanged: (text) async {
              await userService.getUsers(text);
            },
          ),
        ),

      ),
      body: Obx(() {
        return usersModel.users.isNotEmpty ? ListView.builder(
          itemCount: usersModel.users.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(usersModel.users[index]["uuid"].toString()),
            );
          },
        ) : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("검색결과가 없습니다", style: TextStyle(fontSize: 25, color: Colors.grey),)
            ],
          ),
        );
      })
    );
  }
}
