import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo_mine/model/model_todo.dart';
import 'package:get/get.dart';
import '../controller/controller_todo.dart';
import '../controller/controller_user.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/svg.dart';

class ScreenMain extends StatefulWidget {
  @override
  _ScreenMainState createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int touchedIndex = 0;
  var scheduleText = TextEditingController();
  final userController = Get.put(UserController());
  final todoModel = Get.put(RxTodoModel());
  final todoservice = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userController.user.value.email),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("+", style: TextStyle(fontSize: 25),),
        onPressed: () {
          Get.bottomSheet(
            Scaffold(
              appBar: AppBar(
                title: const Text("john na Test"),
                backgroundColor: Colors.blueGrey,
                actions: [
                  InkWell(
                    child: Container(
                      width: 50,
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("+", style: TextStyle(fontSize: 25),)
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          child: Container(
                            height: 300,
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  onPressed: () {
                                    DatePicker.showTimePicker(context,
                                        showTitleActions: true,
                                        showSecondsColumn: false,
                                        onChanged: (date) {

                                        }, onConfirm: (date) {
                                          todoModel.start("${date.hour}:${date.minute}");
                                          print("${todoModel.start}");
                                        }, currentTime: DateTime.now(), locale: LocaleType.ko);
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
                                        onChanged: (date) {

                                        }, onConfirm: (date) {
                                          todoModel.end("${date.hour}:${date.minute}");
                                          print("${todoModel.end}");
                                        }, currentTime: DateTime.now(), locale: LocaleType.ko);
                                  },
                                  child: const Text(
                                    '끝나는 시간 설정하기',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                                        child: const Text("Cancel"),
                                      ),
                                      const Padding(padding: EdgeInsets.only(right: 10)),
                                      ElevatedButton(
                                        onPressed: () {
                                          todoModel.name(scheduleText.text.trim());
                                          todoservice.insertTodo();
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
            ),
          );
        },
      ),
      body: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 30.0 : 26.0;
      final radius = isTouched ? 120.0 : 110.0;
      final widgetSize = isTouched ? 65.0 : 50.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(
              'assets/ophthalmology-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(
              'assets/librarian-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(
              'assets/fitness-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff845bef),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(
              'assets/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff13d38e),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });

  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
        ),
      ),
    );
  }
}
