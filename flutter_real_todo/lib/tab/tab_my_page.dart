import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:get/get.dart';

class TabMyPage extends StatelessWidget {
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              color: Colors.blueGrey,
            ),
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return SizedBox(
                                width: 273,
                                child: Text(
                                  userController.user.value.email,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              );
                            }),
                            Obx(() {
                              return Text(
                                  userController.user.value.email,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                );
                            }),
                          ],
                        )
                      ],
                    ),
                    const Text("content")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
