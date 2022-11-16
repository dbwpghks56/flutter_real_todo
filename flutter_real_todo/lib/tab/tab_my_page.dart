import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_follow.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:get/get.dart';

import '../controller/controller_event.dart';

class TabMyPage extends StatelessWidget {
  final userController = Get.put(UserController());
  final followController = Get.put(FollowController());
  var eventService = Get.put(MyController());
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
        title: Text(searchUser["uuid"].toString().split("@")[0]),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(searchUser["uuid"].toString().split("@")[0]),
                                    Text(searchUser["uuid"], style: const TextStyle(
                                        fontSize: 10, color: Colors.grey
                                    ))
                                  ],
                                ),
                                Obx(() {
                                  return followController.check.isTrue ? ElevatedButton(
                                    onPressed: () async {
                                      followController.unFollow(
                                          searchUser["id"].toString(), userController.user.value.id.toString());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurpleAccent,
                                    ),
                                    child: const Text("UnFollow"),
                                  ) : ElevatedButton(
                                      onPressed: () async {
                                        followController.insertFollow(
                                            searchUser["id"].toString(), userController.user.value.id.toString());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.indigoAccent,
                                      ),
                                      child: const Text("Follow")
                                  );
                                })

                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),
            BoxyId(
                id: #content,
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 365,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 110, left: 10, right: 10),
                          itemCount: eventService.kEventSource.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text("${eventService.kEventSource.keys.elementAt(index)}"),
                                onTap: () async {
                                  eventService.dateEvent(
                                      eventService.kEventSource[eventService.kEventSource.keys.elementAt(index)]);
                                  print("${eventService.dateEvent.value}");
                                },
                              )
                            );
                          },
                        )
                      ),
                      Container(
                        width: 1.5,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.indigoAccent,
                      ),
                      Obx(() {
                        return SizedBox(
                            width: 365,
                            child: ListView.builder(
                              itemCount: eventService.dateEvent.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: ListTile(
                                      title: Text("${eventService.dateEvent[index]}"),
                                      onTap: () {

                                      },
                                    )
                                );
                              },
                            )
                        );
                      }),
                    ],
                  ),
                )
            ),
            BoxyId(
              id: #avatar,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 6),
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
    avatar.position(Offset(1, middle));

    return header.size + Offset(0, content.size.height);
  }
}
