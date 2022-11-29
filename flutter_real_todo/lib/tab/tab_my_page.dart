import 'dart:ui';

import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_chat.dart';
import 'package:flutter_real_todo/controller/controller_follow.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:get/get.dart';

import '../controller/controller_event.dart';

class TabMyPage extends StatelessWidget {
  final userController = Get.put(UserController());
  final followController = Get.put(FollowController());
  final chatController = Get.put(ChatController());
  var eventService = Get.put(MyController());
  final searchUser;

  TabMyPage({required this.searchUser});

  @override
  Widget build(BuildContext context) {
    return searchUser == null ? Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await chatController.getRooms(userController.user.value.id);
            Get.dialog(
              Dialog(
                child:
                  SizedBox(
                    width: 500,
                    child: Obx(() {
                      return Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.indigoAccent,
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: EdgeInsets.only(top: 10),
                            child: const Text(
                              "채팅방 목록",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25, color: Colors.white),),
                          ),

                          Expanded(
                            child: ListView.builder(
                              itemCount: chatController.roomsLang,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(userController.user.value.id != chatController.rooms[index]["users"]["id"] ?
                                    chatController.rooms[index]["users"]["uuid"].toString()
                                        : chatController.rooms[index]["targets"]["uuid"].toString()),
                                    onTap: () async {
                                      chatController.getChats2(
                                          chatController.rooms[index]["users"]["id"],
                                          chatController.rooms[index]["targets"]["id"]
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  )
              )
            );
          },
          backgroundColor: const Color(0xff3B44F6),
          child: const Icon(Icons.message_sharp, color: Colors.white,),
        ),
        body: CustomBoxy(
          delegate: MyBoxy(),
          children: [
            BoxyId(
                id: #header,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.indigoAccent,
                            Color(0xff49a09d)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                      )
                  ),
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
                                    Text(userController.user.value.email.split("@")[0]),
                                    Text(userController.user.value.email, style: const TextStyle(
                                        fontSize: 10, color: Colors.grey
                                    ))
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text("0 Follower", style: TextStyle(color: Colors.grey),),
                                        const Padding(padding: EdgeInsets.only(right: 10)),
                                        Container(
                                          width: 1,
                                          height: 10,
                                          color: Colors.grey,
                                        ),
                                        const Padding(padding: EdgeInsets.only(left: 10)),
                                        const Text("0 Following", style: TextStyle(color: Colors.grey),),
                                      ],
                                    ),
                                  ],
                                ),
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
                            padding: const EdgeInsets.only(top: 120, left: 10, right: 10),
                            itemCount: eventService.kEventSource.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.indigoAccent),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                      color: Colors.indigoAccent.withOpacity(0.8),
                                      spreadRadius: 0.5,
                                      blurRadius: 0.5,
                                      offset: const Offset(0, 1),
                                    )],
                                  ),
                                  margin: const EdgeInsets.only(bottom: 13),
                                  child: ListTile(
                                    title: Text("${eventService.kEventSource.keys.elementAt(index).toString().split(" ")[0]}"
                                        "의 일정"),

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
                        width: 3.5,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigoAccent,
                                Color(0xff49a09d)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                      ),
                      Obx(() {
                        return Container(
                            width: 700,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 20, left: 30),
                              itemCount: eventService.dateEvent.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(
                                        color: Colors.grey.withOpacity(0.8),
                                        spreadRadius: 0.5,
                                        blurRadius: 0.5,
                                        offset: const Offset(0, 1),
                                      )],
                                    ),
                                    margin: const EdgeInsets.only(bottom: 13),
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
                  backgroundImage: NetworkImage("https://thumb.mt.co.kr/06/2022/08/2022081109301286132_1.jpg/dims/optimize/"),
                ),
              ),
            ),
          ],
        )) : Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await eventService.getEvents(userController.user.value.id);
            Get.back();
          },
          backgroundColor: const Color(0xff3B44F6),
          child: const Icon(Icons.keyboard_backspace, color: Colors.white,),
        ),
        body: CustomBoxy(
          delegate: MyBoxy(),
          children: [
            BoxyId(
                id: #header,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigoAccent,
                        Color(0xff49a09d)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                    )
                  ),
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text("0 Follower", style: TextStyle(color: Colors.grey),),
                                        const Padding(padding: EdgeInsets.only(right: 10)),
                                        Container(
                                          width: 1,
                                          height: 10,
                                          color: Colors.grey,
                                        ),
                                        const Padding(padding: EdgeInsets.only(left: 10)),
                                        const Text("0 Following", style: TextStyle(color: Colors.grey),),
                                      ],
                                    ),
                                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
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
                                        }),
                                        const Padding(padding: EdgeInsets.only(right: 10)),
                                        ElevatedButton(
                                          onPressed: () async {
                                            chatController.getChats2(
                                                userController.user.value.id,
                                                searchUser["id"]
                                            );
                                          },
                                          child: const Text("Message"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                          padding: const EdgeInsets.only(top: 120, left: 10, right: 10),
                          itemCount: eventService.kEventSource.length,
                          itemBuilder: (context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.indigoAccent),
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(
                                    color: Colors.indigoAccent.withOpacity(0.8),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    offset: const Offset(0, 1),
                                  )],
                                ),
                                margin: const EdgeInsets.only(bottom: 13),
                                child: ListTile(
                                  title: Text("${eventService.kEventSource.keys.elementAt(index).toString().split(" ")[0]}"
                                      "의 일정"),

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
                        width: 3.5,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.indigoAccent,
                              Color(0xff49a09d)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        ),
                      ),
                      Obx(() {
                        return Container(
                          width: 700,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 20, left: 30),
                            itemCount: eventService.dateEvent.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    offset: const Offset(0, 1),
                                  )],
                                ),
                                margin: const EdgeInsets.only(bottom: 13),
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
                  backgroundImage: NetworkImage("https://thumb.mt.co.kr/06/2022/08/2022081109301286132_1.jpg/dims/optimize/"),
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
