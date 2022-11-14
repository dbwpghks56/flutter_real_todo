import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:get/get.dart';

class TabMyPage extends StatelessWidget {
  final userController = Get.put(UserController());
  final searchUser;

  TabMyPage({required this.searchUser});

  @override
  Widget build(BuildContext context) {
    return searchUser == null ? Scaffold(
      body: CustomBoxy(
        delegate: MyBoxy(),
        children: [
          BoxyId(
              id: #header,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.indigoAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 200,
                    ),
                    Container(
                      width: 600,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
          ),
          BoxyId(
              id: #content,
              child: Container(

              )
          ),
          BoxyId(
              id: #avatar,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )],
                  border: Border.all(color: Colors.indigoAccent, width: 1.5),
                ),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
                child: const CircleAvatar(
                  backgroundImage: NetworkImage("https://pbs.twimg.com/media/Eq8SyXzUUAAuU9g.jpg"),
                ),
              ),
          ),
        ],
      )) : Scaffold(
      appBar: AppBar(
        title: Text("${searchUser["uuid"]}"),
      ),
        body: CustomBoxy(
          delegate: MyBoxy(),
          children: [
            BoxyId(
                id: #header,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.indigoAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 200,
                      ),
                      Container(
                        width: 600,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
            ),
            BoxyId(
                id: #content,
                child: Container(

                )
            ),
            BoxyId(
              id: #avatar,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )],
                  border: Border.all(color: Colors.indigoAccent, width: 1.5),
                ),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
                child: const CircleAvatar(
                  backgroundImage: NetworkImage("https://pbs.twimg.com/media/Eq8SyXzUUAAuU9g.jpg"),
                ),
              ),
            ),
          ],
        ));
  }
}

class MyBoxy extends BoxyDelegate {
  @override Size layout() {
    final header = getChild(#header);
    final content = getChild(#content);
    final avatar = getChild(#avatar);
    
    header.layout(constraints);
    content.layout(constraints);
    content.position(header.rect.bottomLeft);
    avatar.layout(constraints);

    final middle = header.size.height - avatar.size.height / 2;
    avatar.position(Offset(0, middle));

    return header.size + Offset(0, content.size.height);
  }
}
