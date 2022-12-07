import 'package:flutter/material.dart';
import 'package:flutter_real_todo/tab/tab_my_page.dart';
import 'package:flutter_real_todo/util/tag.dart';
import 'package:get/get.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';

class TagCard extends StatelessWidget {
  final userService = Get.put(UserController());
  List tagName;
  Color? textColor = Colors.black;

  TagCard({required this.tagName, this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tagName.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if(tagName[index]["users"]["id"] == userService.user.value.id) {
                Get.to(() => TabMyPage(searchUser: null));
              } else {
                Get.to(() => TabMyPage(searchUser: tagName[index]["users"]));
              }
            },
            child: Tag(
              tag: tagName[index]["users"]["uuid"],
              textColor: textColor,
            )
          );
        },
      ),
    );
  }
}
