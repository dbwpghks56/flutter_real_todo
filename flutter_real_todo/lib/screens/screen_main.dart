import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_real_todo/model/model_todo.dart';
import 'package:get/get.dart';
import 'package:radar_chart/radar_chart.dart';
import '../controller/controller_todo.dart';
import '../controller/controller_user.dart';
// import 'package:fl_chart/fl_chart.dart';

class ScreenMain extends StatefulWidget {
  @override
  _ScreenMainState createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int touchedIndex = 0;
  final int _length = 24;
  var scheduleText = TextEditingController();
  final userController = Get.put(UserController());
  final todoModel = Get.put(RxTodoModel());
  final todoservice = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.menu,size: 25,),
          onPressed: () async {
            todoservice.getTodos();
            Get.bottomSheet(
              Scaffold(
                appBar: AppBar(
                  title: const Text("나의 일정"),
                  backgroundColor: Colors.blueGrey,
                  actions: [
                    InkWell(
                      child: Container(
                        width: 50,
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "+",
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.dialog(
                          Dialog(
                            child: SizedBox(
                              height: 350,
                              width: 300,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 200,
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: TextField(
                                      controller: scheduleText,
                                      decoration: const InputDecoration(
                                        label: Text("To do"),
                                        hintText: "할 일을 적어주세요.",
                                      ),
                                    ),
                                  ),
                                  Obx(() {
                                    return SizedBox(
                                      width: 200,
                                      child: TextField(
                                        readOnly: true,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          label: Text("${todoModel.start}"),
                                        ),
                                      ),
                                    );
                                  }),
                                  TextButton(
                                    onPressed: () async {
                                      DatePicker.showTimePicker(
                                        context,
                                        showTitleActions: true,
                                        showSecondsColumn: false,
                                        onChanged: (date) {},
                                        onConfirm: (date) {
                                          if (confirmMinutes(date.minute) ==
                                              1) {
                                            Get.showSnackbar(const GetSnackBar(
                                              title: "Todo",
                                              message: "30분 단위로 입력하세요.",
                                              duration: Duration(seconds: 1),
                                            ));
                                          } else {
                                            todoModel.start(
                                                "${date.hour}:${date.minute}");
                                            print("${todoModel.start}");
                                          }
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.ko,
                                      );
                                    },
                                    child: const Text(
                                      '시작 시간 설정하기',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  Obx(() {
                                    return SizedBox(
                                      width: 200,
                                      child: TextField(
                                        readOnly: true,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          label: Text("${todoModel.end}"),
                                        ),
                                      ),
                                    );
                                  }),
                                  TextButton(
                                    onPressed: () {
                                      DatePicker.showTimePicker(context,
                                          showTitleActions: true,
                                          showSecondsColumn: false,
                                          onChanged: (date) {},
                                          onConfirm: (date) {
                                        if (confirmMinutes(date.minute) == 1) {
                                          Get.showSnackbar(const GetSnackBar(
                                            title: "Todo",
                                            message: "30분 단위로 입력하세요.",
                                            duration: Duration(seconds: 1),
                                          ));
                                        } else {
                                          print(date);
                                          todoModel.end(
                                              "${date.hour}:${date.minute}");
                                          print("${todoModel.end}");
                                        }
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.ko);
                                    },
                                    child: const Text(
                                      '끝나는 시간 설정하기',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Obx(() {
                                          return ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                Dialog(
                                                  child: BlockPicker(
                                                    pickerColor: Color(todoModel.tabColor.value),
                                                    onColorChanged: (color) {
                                                      todoModel.tabColor(color.value);
                                                    },
                                                  ),
                                                )
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(todoModel.tabColor.value)),
                                            child: const Text("색 정하기"),
                                          );
                                        }),
                                        const Padding(
                                            padding:
                                            EdgeInsets.only(right: 10)),
                                        ElevatedButton(
                                          onPressed: () {
                                            todoModel.name("name");
                                            scheduleText.text = "";
                                            todoModel.start("start-time");
                                            todoModel.end("end-time");
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blueGrey),
                                          child: const Text("Cancel"),
                                        ),
                                        const Padding(
                                            padding:
                                                EdgeInsets.only(right: 10)),
                                        ElevatedButton(
                                          onPressed: () {
                                            todoModel
                                                .name(scheduleText.text.trim());
                                            scheduleText.text = "";
                                            todoservice.insertTodo();
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue),
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                body: Obx(() {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: ListView.builder(
                      itemCount: todoModel.todos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              todoModel.todos[index]["todoName"].toString()),
                          subtitle: Row(
                            children: [
                              Text(
                                  "${todoModel.todos[index]["startTime"].toString()} ~ ${todoModel.todos[index]["endTime"].toString()}"),
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircleAvatar(
                                  backgroundColor: Color(parseInt(todoModel.todos[index]["tabColor"])),
                                ),
                              )
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.deepOrangeAccent,
                            onPressed: () {
                              todoservice.deleteTodo(todoModel.todos[index]);
                            },
                          ),
                          onTap: () {
                            todoModel
                                .start(todoModel.todos[index]["startTime"]);
                            todoModel.end(todoModel.todos[index]["endTime"]);
                            Get.dialog(
                              Dialog(
                                child: Container(
                                  height: 350,
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 200,
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        child: TextField(
                                          controller: scheduleText
                                            ..text = todoModel.todos[index]
                                                ["todoName"],
                                          decoration: const InputDecoration(
                                            label: Text("To do"),
                                            hintText: "할 일을 적어주세요.",
                                          ),
                                        ),
                                      ),
                                      Obx(() {
                                        return SizedBox(
                                          width: 200,
                                          child: TextField(
                                            readOnly: true,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              label: Text("${todoModel.start}"),
                                            ),
                                          ),
                                        );
                                      }),
                                      TextButton(
                                        onPressed: () {
                                          DatePicker.showTimePicker(context,
                                              showTitleActions: true,
                                              showSecondsColumn: false,
                                              onChanged: (date) {},
                                              onConfirm: (date) {
                                            if (confirmMinutes(date.minute) ==
                                                1) {
                                              Get.showSnackbar(
                                                  const GetSnackBar(
                                                title: "Todo",
                                                message: "30분 단위로 입력하세요.",
                                                duration: Duration(seconds: 1),
                                              ));
                                            } else {
                                              todoModel.start(
                                                  "${date.hour}:${date.minute}");
                                              print("${todoModel.start}");
                                            }
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.ko);
                                        },
                                        child: const Text(
                                          '시작 시간 설정하기',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                      Obx(() {
                                        return SizedBox(
                                          width: 200,
                                          child: TextField(
                                            readOnly: true,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              label: Text("${todoModel.end}"),
                                            ),
                                          ),
                                        );
                                      }),
                                      TextButton(
                                        onPressed: () {
                                          DatePicker.showTimePicker(context,
                                              showTitleActions: true,
                                              showSecondsColumn: false,
                                              onChanged: (date) {},
                                              onConfirm: (date) {
                                            if (confirmMinutes(date.minute) ==
                                                1) {
                                              Get.showSnackbar(
                                                  const GetSnackBar(
                                                title: "Todo",
                                                message: "30분 단위로 입력하세요.",
                                                duration: Duration(seconds: 1),
                                              ));
                                            } else {
                                              todoModel.end(
                                                  "${date.hour}:${date.minute}");
                                              print("${todoModel.end}");
                                            }
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.ko);
                                        },
                                        child: const Text(
                                          '끝나는 시간 설정하기',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                todoModel.name("name");
                                                scheduleText.text = "";
                                                todoModel.start("start-time");
                                                todoModel.end("end-time");
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.blueGrey),
                                              child: const Text("Cancel"),
                                            ),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10)),
                                            ElevatedButton(
                                              onPressed: () {
                                                todoModel.name(
                                                    scheduleText.text.trim());
                                                scheduleText.text = "";
                                                todoservice.updateTodo(todoModel
                                                    .todos[index]["id"]);
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.deepPurple),
                                              child: const Text("update"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            );
          },
        ),
        body: Center(
          child:
            Obx(() {
              return RadarChart(
                radius: 150.0,
                initialAngle: pi/3,
                length: _length,
                borderStroke: 1.0,
                borderColor: Colors.black.withOpacity(0.4),
                radars: showingRadar(),
                vertices: List.generate(24, (index) {
                  if(index > 14) {
                    return PreferredSize(
                        preferredSize: const Size.square(2 * 8),
                        child: Text("${index-14}", style: const TextStyle(
                            fontSize: 20
                        ),
                        )
                    );
                  } else {
                    return PreferredSize(
                        preferredSize: const Size.square(2 * 8),
                        child: Text("${index+10}", style: const TextStyle(
                          fontSize: 20,
                        ),),
                    );
                  }
                })
              );
            })),
         );
  }

  List<RadarTile> showingRadar() {
    return List.generate(todoModel.todos.length, (index) {
      return RadarTile(
        values: getValues(index),
        backgroundColor: Color(parseInt(todoModel.todos[index]["tabColor"])).withOpacity(0.6),
      );
    });
  }

  List<double> getValues(int index) {
    List<double> value = [];

    for(int i = 0; i < 24; i++) {
      value.add(0.0);
    }
    int startH = parseInt(todoModel.todos[index]["startTime"]);
    double durationT = todoModel.todos[index]["durationTime"];

    if((startH ~/ 10) > 0) {
      startH -= 10;
      for(int i = startH; i <= startH+durationT; i++) {
        value.insert(i, 1.0);
      }
    } else if((startH ~/ 10) == 0)  {
      startH += 14;

      for(int i = startH; i <= startH+durationT; i++) {
        value.insert(i, 1.0);
      }
    }

    return value;
  }

  int confirmMinutes(int min) {
    if (min == 0 || min == 30) {
      return min;
    } else {
      return 1;
    }
  }

  int parseInt(String convert) {
    return int.parse(convert.split(":")[0]);
  }
}
